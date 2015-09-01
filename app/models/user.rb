class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword

  field :email, type: String, :index => true
  field :password_digest, type: String
  field :password_reset_token, type: String, :index => true

  has_secure_password

  has_many :vehicles

  validates :password, presence: true,
                       length: { minimum: 8 },
                       on: :create
  # validates :email, presence: true
  validates :email, presence: true,
                    uniqueness: {
                      case_sensitive: false,
                      message: "is already taken"
                    }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update({password_reset_token: SecureRandom.urlsafe_base64(64)})
  end
end
