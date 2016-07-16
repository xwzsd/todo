class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
 
  validates :email, uniqueness: {case_sensitive: false}
  has_many :todo_lists, dependent: :destroy
end
