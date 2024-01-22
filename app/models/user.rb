class User < ApplicationRecord
  belongs_to :companies, optional: true
  belongs_to :company, optional: true
  has_secure_password
  validates :type_user, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: false
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def superadmin?
    type_user == 'superadmin'
  end

  def admin?
    type_user == 'admin' || type_user == 'superadmin'
  end

  def user?
    type_user == 'user' || type_user == 'admin' || type_user == 'superadmin'
  end
end
