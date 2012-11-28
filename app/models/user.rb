class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, :presence => true

  def super_admin?
    has_role? :super_admin
  end

  def admin?
    has_role?(:admin)
  end
end
