# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    attr_reader :password
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true
    validates :password_digest, presence: true 
    before_validation :ensure_session_token

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def find_by_creds(username, password)
        user = User.find_by(username: username)
        if user && is_password(password)
            user 
        else 
            nil
        end
    end

    def is_password?(new_pass)
        obj = Bcrypt::Password.new(new_pass)
        obj.is_password?
    end

    
end