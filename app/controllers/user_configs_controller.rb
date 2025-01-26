class UserConfigsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_config, only: [:edit, :update]

  def index
    @user_configs = current_user.user_configs
  end

  def library
    admin_user = User.find_by(admin: true) # Encontra o usuário administrador
    if admin_user
      @user_configs = admin_user.user_configs # Configurações criadas pelo admin
    else
      @user_configs = UserConfig.none # Caso não haja admin, retorna vazio
    end
  end
   
  
  def new
    @user_config = current_user.user_configs.new
  end

  def create
    @user_config = current_user.user_configs.new(user_config_params)
    if @user_config.save
      redirect_to chatbot_show_path, notice: "Configuração criada com sucesso!"
    else
      render :new
    end
  end
  
  def update
    @user_config = current_user.user_configs.find(params[:id])
    if @user_config.update(user_config_params)
      redirect_to chatbot_show_path, notice: "Configuração atualizada com sucesso!"
    else
      render :edit, alert: "Erro ao atualizar a configuração."
    end
  end
  

  def destroy
    @user_config = current_user.user_configs.find(params[:id])
    
    if @user_config.destroy
      redirect_to user_configs_path, notice: "Configuração excluída com sucesso."
    else
      redirect_to user_configs_path, alert: "Erro ao excluir a configuração."
    end
  end

  def edit; end

  def update
    if @user_config.update(user_config_params)
      redirect_to user_configs_path, notice: "Configuração atualizada com sucesso!"
    else
      render :edit
    end
  end

  def save
    user_config = UserConfig.find(params[:id]) # Busca o bot pelo ID
    saved_config = current_user.user_configs.new(user_config.attributes.except("id", "created_at", "updated_at"))
  
    # Copiar a imagem, se houver
    if user_config.imagem.attached?
      saved_config.imagem.attach(user_config.imagem.blob) 
    end
  
    if saved_config.save
      redirect_to user_configs_path, notice: "Bot salvo com sucesso!"
    else
      redirect_to library_user_configs_path, alert: "Erro ao salvar o bot."
    end
  end
  
  

  private

  def set_user_config
    @user_config = current_user.user_configs.find(params[:id])
  end

  def user_config_params
    params.require(:user_config).permit(:nome_bot, :temperatura, :finalidade, :base_de_dados, :estrutura_desejo, :exemplo_referencia, :config_pdf)
  end
  
end
