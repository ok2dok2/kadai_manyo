class User < ApplicationRecord
  before_update :last_admin_update 
  before_destroy :last_admin_delete

  has_many :tasks, dependent: :destroy
  has_secure_password

  before_validation { email.downcase! }

  private
  
  def last_admin_update
    throw :abort if User.where(admin: :true).count == 1 && User.present? && self.admin == false
    errors.add(:admin, 'から外せません。最低一人の管理者が必要です')
  end

  def last_admin_delete
    throw :abort if User.where(admin: :true).count == 1 && self.admin ==  true
  end
end
