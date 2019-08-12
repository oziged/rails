class User < ApplicationRecord
  has_many :posts
  has_many :comments

  has_secure_password

  validates :email, presence: true, uniqueness: true

  def avatar
    'https://miro.medium.com/max/800/0*QCRunR_VjAIrvkjC.png'
  end
end