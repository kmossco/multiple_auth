class UserAuthentication < ApplicationRecord
  PROVIDERS = ["google_oauth2", "azure_activedirectory_v2"].freeze

  belongs_to :user, required: true

  validates :provider, inclusion: PROVIDERS

  def self.create_for(user, auth)
    expires_at = auth.credentials.expires_at

    user.user_authentications.create!(
      provider: auth.provider,
      uid: auth.uid,
      token: auth.credentials.token,
      token_expires_at: (expires_at ? Time.at(expires_at) : nil)
    )
  end
end
