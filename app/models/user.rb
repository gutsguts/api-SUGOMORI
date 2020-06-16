# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
  before_save -> { skip_confirmation! }
  #  , omniauth_providers: %i[facebook]

  #  omniauth_providers: %i[facebook twitter github]
  #  :confirmable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  # def self.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # def self.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?

  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  has_many :social_profiles, dependent: :destroy
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end
end
