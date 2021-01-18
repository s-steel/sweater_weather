class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true
  validates :api_key, uniqueness: true

  has_secure_password
  has_secure_token :api_key
end
