class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save   :downcase_email

  include Authenticatable, Friendable, Emailable, Administratable, Groupable

  include UsersHelper

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :posts, dependent: :destroy

  # More validations for name, email and password length
  # to be included before pushing to Production
  validates :name, presence: true, length: { minimum: 1 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Methods

  # Remembers user for persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # Forgets user for persistent session
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def downcase_email
      self.email = self.email.downcase
    end
end
