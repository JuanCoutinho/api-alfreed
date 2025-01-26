require 'net/http'
require 'json'

class ChatbotController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_configs = current_user.user_configs
    @user_config = @user_configs.first

    if @user_config.nil?
      redirect_to new_user_config_path, alert: "Por favor, crie uma configuração do bot antes de usar o chat."
    end
  end

  def interact
    user_config = current_user.user_configs.find_by(id: params[:config_id])

    unless user_config
      render json: { error: "Configuração do bot não encontrada" }, status: :not_found
      return
    end

    payload = {
      config: {
        nome_bot: user_config.nome_bot || "Bot Padrão",
        temperatura: user_config.temperatura || "moderado",
        finalidade: user_config.finalidade || "geral",
        user_name: user_config.user_name || "Usuário Padrão", 
        base_de_dados: user_config.base_de_dados || {},
        estrutura_desejo: user_config.estrutura_desejo || {},
        exemplo_referencia: user_config.exemplo_referencia || {},
        input: params[:message].presence || "Mensagem padrão"
      },
      input: params[:message].presence || "Mensagem padrão"
    }
    
    

  Rails.logger.info("Payload enviado para a API: #{payload.to_json}")

  begin
    uri = URI("http://127.0.0.1:4567/chat")
    response = Net::HTTP.post(uri, payload.to_json, { "Content-Type" => "application/json" })

    Rails.logger.info("Resposta da API: #{response.body}, Status: #{response.code}")

    if response.is_a?(Net::HTTPSuccess)
      result = JSON.parse(response.body, symbolize_names: true)
      
      formatted_response = format_message(result[:message])

      Rails.logger.info("Resposta formatada: #{formatted_response}")

      render json: { response: formatted_response }
    else
      error_message = JSON.parse(response.body)["error"] rescue "Erro desconhecido"
      render json: { error: error_message }, status: :unprocessable_entity
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Erro ao processar a resposta da API: #{e.message}")
    render json: { error: "Resposta inválida da API" }, status: :internal_server_error
  rescue StandardError => e
    Rails.logger.error("Erro ao conectar com a API: #{e.message}")
    render json: { error: "Erro ao conectar com a API do chatbot: #{e.message}" }, status: :internal_server_error
  end
end

def format_message(message)
  message = message.gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>')
  message = message.gsub(/^-\s+(.*)$/, '<ul><li>\1</li></ul>').gsub(/(<ul><li>.*<\/li><\/ul>)/, '<ul>\1</ul>')
  message = message.gsub(/^1\.\s+(.*)$/, '<ol><li>\1</li></ol>').gsub(/(<ol><li>.*<\/li><\/ol>)/, '<ol>\1</ol>')
  sanitized_message = Sanitize.fragment(message, elements: ['strong', 'em', 'b', 'i', 'ul', 'ol', 'li', 'br'])

  sanitized_message
end

  def edit
    @user_config = current_user.user_configs.find(params[:id])

    unless @user_config
      redirect_to chatbot_show_path, alert: "Configuração não encontrada."
    end
  end

  # Ação de atualização da configuração
  def update
    @user_config = current_user.user_configs.find(params[:id])

    if @user_config.update(user_config_params)
      redirect_to chatbot_show_path, notice: "Configuração atualizada com sucesso!"
    else
      render :edit, alert: "Erro ao atualizar a configuração."
    end
  end

  # Ação para excluir a configuração
  def destroy
    @user_config = current_user.user_configs.find(params[:id])
    if @user_config.destroy
      redirect_to user_configs_path, notice: "Configuração excluída com sucesso."
    else
      redirect_to user_configs_path, alert: "Erro ao excluir a configuração."
    end
  end
  

  private

  # Permitindo os parâmetros da configuração
  def user_config_params
    params.require(:user_config).permit(:nome_bot, :temperatura, :finalidade, :base_de_dados, :estrutura_desejo, :exemplo_referencia, :imagem)
  end
end
