class BannersController < ApplicationController
  before_action :set_banner, only: [:edit, :update, :destroy]

  def index
    @banners = Banner.all
  end

  def show
    @banner = Banner.find(params[:id])
  end
  
  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      redirect_to banners_path, notice: 'Banner criado com sucesso.'
    else
      flash[:alert] = 'Erro ao criar o banner. Verifique os campos obrigatórios.'
      render :new
    end
  end

  def edit
  end

  def update
    if @banner.update(banner_params)
      redirect_to banners_path, notice: 'Banner atualizado com sucesso.'
    else
      flash[:alert] = 'Erro ao atualizar o banner. Verifique os campos obrigatórios.'
      render :edit
    end
  end

  def destroy
    @banner.destroy
    redirect_to banners_path, notice: 'Banner excluído com sucesso.'
  rescue ActiveRecord::RecordNotFound
    redirect_to banners_path, alert: 'Banner não encontrado para exclusão.'
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to banners_path, alert: 'Banner não encontrado.'
  end

  def banner_params
    params.require(:banner).permit(:image, :link)
  end
end
