class User < ApplicationRecord
  has_many :tasks
  has_secure_password

  before_validation { email.downcase! }
end
