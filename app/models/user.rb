class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! } #バリデーション判定前にemail属性を強制的に小文字に変換
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :posts
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
end
