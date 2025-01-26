class HomeController < ApplicationController
  before_action :authenticate_user!

  def home
    @cards = [
      { 
        icon: 'fas fa-comments', 
        title: 'Chat Bot', 
        description: 'Gerencie o seu chatbot aqui. Veja as conversas e interaja com os usuários.', 
        link_text: 'Acessar Chat', 
        link_path: chat_path + '?',
        image: '1.png' 
      },
      { 
        icon: 'fas fa-user', 
        title: 'Perfil', 
        description: 'Edite as informações do seu perfil e mantenha suas configurações pessoais atualizadas.', 
        link_text: 'Editar Perfil', 
        link_path: edit_user_registration_path,
        image: '2.png'
      },
      { 
        icon: 'fas fa-cogs', 
        title: 'Configurações do Usuário', 
        description: 'Acesse e atualize as configurações relacionadas ao seu usuário.', 
        link_text: 'Abrir Configurações', 
        link_path: user_configs_path,
        image: '3.png'
      },
      { 
        icon: 'fas fa-video', 
        title: 'Lives Ativas', 
        description: 'Visualize e gerencie as lives ativas atualmente.', 
        link_text: 'Ver Lives Ativas', 
        link_path: videos_path,
        image: '4.png'
      }
    ]
  end
end
