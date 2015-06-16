class User
  include Mongoid::Document
  field :username, type: String
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :password_digest, type: String
end
