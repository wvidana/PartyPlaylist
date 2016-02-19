class User < ActiveRecord::Base
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauth_providers => [:spotify]

  validates_uniqueness_of :spoti_id

  def self.from_omniauth(auth)
    where(spoti_id: auth.info.id).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.spoti_id = auth.info.id
    end
  end
end
