class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
    # Validation rules
    

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.id = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.full_name = auth.info.name
        user.roles = "admin"
        user.status = 1
        user.company_id = auth.uid
        user.uid = auth.uid
        user.created_date = Time.now.utc
        user.modified_date = Time.now.utc
      end
    end

    private

    def assign_created_date
      self.created_date = Time.now.utc
      self.modified_date = Time.now.utc
    end
end
  