# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  attr_reader :password
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :moderator_id, class_name: 'Sub',
    dependent: :destroy
  has_many :posts, foreign_key: :author_id, class_name: 'Post',
    dependent: :destroy

  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    return user if user && user.is_password?(pw)
    nil
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
