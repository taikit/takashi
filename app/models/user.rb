class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :plans
  has_many :bookings

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         token: auth.credentials.token,
                         facebook_url: auth.info.urls.Facebook,
                         password: Devise.friendly_token[0, 20])
    end

    return user
  end
end
