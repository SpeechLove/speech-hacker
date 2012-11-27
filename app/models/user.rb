class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  before_create :set_role

  validates :name, :presence => true

  def set_role
    self.add_role :admin
  end
end
