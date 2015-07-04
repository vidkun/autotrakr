class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username, type: String
  field :email, type: String #need an index on this
  field :first_name, type: String
  field :last_name, type: String
  field :password_digest, type: String
  field :password_reset_token, type: String  #need an index on this

  has_secure_password

  validates :password, presence: true,
                       length: { minimum: 8 },
                       on: :create
  validates_presence_of :username,
                        :email
  validates_uniqueness_of :username,
                          :email,
                          case_sensitive: false,
                          message: 'is already taken'

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(64))
  end
end
