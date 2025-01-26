class VideoMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "video_messages_#{params[:video_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
