class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :webpages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }

  before_save :downcase_email
  validates :email, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password
  # For symbols:
  #  (?=.*[[:^alnum:]]) # At least on symbol
  PASSWORD_REQUIREMENTS = /\A
    (?=.{8,}) # At least 8 characters long
    (?=.*\d) # At least one number
    (?=.*[a-z]) # At least one lowercase
    (?=.*[A-Z]) # At least one uppercase
  /x
  validates :password, format: {
    with: PASSWORD_REQUIREMENTS,
    message: 'must be 8+ characters, and must include: number, lowercase and uppercase letters.'
  }

  attr_accessor :remember_token, :activation_token, :reset_token

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  # Converts email to all lowercase.
  def downcase_email
    self.email = email.downcase
  end
end
