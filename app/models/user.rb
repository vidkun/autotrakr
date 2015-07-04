class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String #need an index on this
  field :password_digest, type: String
  field :password_reset_token, type: String  #need an index on this

  index :email => 1
  index :password_reset_token => 1

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 8 },
                       on: :create
  validates_presence_of :email
  validates_uniqueness_of :email,
                          case_sensitive: false,
                          message: "is already taken"

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(64))
  end
end
