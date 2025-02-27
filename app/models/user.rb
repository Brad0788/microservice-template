class User < ApplicationRecord

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :roles, length: { maximum: 100 }
  validates :status, presence: true, numericality: { only_integer: true }
  validates :company_id, presence: false
  validates :created_date, presence: false
  validates :modified_date, presence: false
  validates :deleted_date, presence: false

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= Ability.new(self)
  end

devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :validatable,
:omniauthable, omniauth_providers: [:google_oauth2]

    before_create :assign_created_date

    private

    def assign_created_date
      self.created_date = Time.now.utc
      self.modified_date = Time.now.utc
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  
        user.id = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.full_name = auth.info.name
        user.roles = "cliente"
        user.status = 1
        user.company_id = auth.uid
        user.uid = auth.uid
        user.telefono = null
        user.created_date = Time.now.utc
        user.modified_date = Time.now.utc
      end
    end
end