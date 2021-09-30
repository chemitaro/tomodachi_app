class User < ApplicationRecord
  has_many :pictures
  validate :name, presence: true, length: { maximum: 30 }
  validate :email, presence: true, length: { maximum: 1..255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: true
  before_validation { email.downcase!}
  has_secure_password
  validate :password, length: { minimum: 6 }
end
