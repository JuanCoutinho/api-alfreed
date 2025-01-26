class UserConfig < ApplicationRecord
  belongs_to :user
  has_one_attached :imagem
end
