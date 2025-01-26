class Video < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :video_messages, dependent: :destroy
end
