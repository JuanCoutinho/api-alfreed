class User < ApplicationRecord
  has_many :videos, dependent: :destroy  # Adicionando associação de vídeos
  has_one_attached :config_pdf
  has_many :user_configs, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def approved?
          self.approved
        end
end
  