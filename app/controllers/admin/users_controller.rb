class Admin::UsersController < ApplicationController
  before_action :authenticate_admin! # Apenas se tiver autenticação de administrador
  
  def index
    @users = User.all
  end

  def approve
    user = User.find(params[:id])
    if user.update(approved: true)
      redirect_to admin_users_path, notice: "User approved successfully!"
    else
      redirect_to admin_users_path, alert: "Failed to approve user."
    end
  end
  
  def reject
    user = User.find(params[:id])
    if user.update(approved: false)
      redirect_to admin_users_path, notice: "User rejected successfully!"
    else
      redirect_to admin_users_path, alert: "Failed to reject user."
    end
  end
  
end
