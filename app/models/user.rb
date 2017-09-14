class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,:omniauthable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :reviews
  has_one :user_detail

   def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(username:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         confirmed_at: Time.now)
    end
    user

  end
end
