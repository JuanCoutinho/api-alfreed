class ApplicationController < ActionController::Base
    before_action :check_approval
  
    private
  
    def check_approval
      if current_user && !current_user.approved?
        flash[:alert] = "Sua conta está em analise para ser aprovada pelo administrador."
        sign_out current_user
        redirect_to new_user_session_path
      end
    end

    def authenticate_admin!
        unless current_user&.admin?
          redirect_to root_path, alert: "Access denied! You must be an admin to access this page."
        end
      end
  end
  