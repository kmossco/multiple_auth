class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:azure_activedirectory_v2, :google_oauth2]

  has_many :user_authentications, dependent: :destroy

  def self.from_omniauth(auth)
    authentication = UserAuthentication.find_by(
      provider: auth.provider, uid: auth.uid
    )
    return authentication.user if authentication

    email = auth.info.email
    existing_user = find_for_database_authentication(email: email.downcase)

    if existing_user
      UserAuthentication.create_for(existing_user, auth)
      existing_user
    else
      create!(email: email, password: Devise.friendly_token[0,20]).tap do |user|
        UserAuthentication.create_for(user, auth)
      end
    end
  end
end
