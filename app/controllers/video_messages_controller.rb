class VideoMessagesController < ApplicationController
  before_action :set_video

  def create
    @message = @video.video_messages.new(content: message_params[:content], user: current_user)

    if @message.save
      # Envia a mensagem para o ActionCable
      ActionCable.server.broadcast(
        "video_messages_#{@video.id}",
        render_to_string(partial: "video_messages/message", locals: { message: @message })
      )

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @video } 
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def message_params
    params.require(:video_message).permit(:content)
  end
end
