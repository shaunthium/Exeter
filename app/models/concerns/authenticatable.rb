module Authenticatable
  extend ActiveSupport::Concern

  included do
    has_secure_password
    validates :password, length: { minimum: 1 }
  end

  module ClassMethods
    # Returns hash digest of given string
    # Class method, as no need for a user instance
    def User.digest(string)
      BCrypt::Password.create(string)
    end

    # Returns url-safe base-64 token
    # Class method, as no need for a user instance
    def User.new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Checks if given token matches digest
  # Same function as BCrypt's authenticate method
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
