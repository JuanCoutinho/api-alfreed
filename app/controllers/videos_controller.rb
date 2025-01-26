class VideosController < ApplicationController
    before_action :authenticate_user!  # Garante que o usuário esteja autenticado
  
    def index
        @videos = Video.all  # Exibe todos os vídeos no banco de dados
      end
  
# Controller
def show
  @video = Video.find(params[:id])
  @messages = @video.video_messages.includes(:user) # Carregue as mensagens com o usuário
  @message = VideoMessage.new
end

  
    def new
      @video = current_user.videos.build  # Cria um novo vídeo para o usuário atual
    end
  
    def create
      @video = current_user.videos.build(video_params)
    
      if @video.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to videos_path, notice: 'Vídeo criado com sucesso.' }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
    
  
    def edit
        @video = Video.find(params[:id])  # Encontra o vídeo específico para edição
      end
    
      def update
        @video = Video.find(params[:id])
        if @video.update(video_params)
          redirect_to @video, notice: 'Vídeo atualizado com sucesso.'
        else
          render :edit
        end
      end
    
      def destroy
        @video = current_user.videos.find(params[:id])
        @video.destroy
      
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to videos_path, notice: 'Vídeo excluído com sucesso.' }
        end
      end
      
  
    private
  
    def video_params
      params.require(:video).permit(:title, :description, :embed_code)
    end
  end
  