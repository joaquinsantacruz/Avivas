class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def can_manage_users?
    has_role?(:manager) || has_role?(:admin)
  end

  def assign_role(role_name)
    if Role.exists?(name: role_name)
      self.roles = []
      add_role(role_name)
    end
  end
end
