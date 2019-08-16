class User < ApplicationRecord
  mount_uploader :avatar, ImagesUploader

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  scope :search_by_fullname, -> (input) { 
    input = input.split(' ').map{|word|word.capitalize}.join(' ')
    User.where("CONCAT_WS(' ', name, surname) LIKE ? or CONCAT_WS(' ', surname, name) LIKE ?", "%#{input}%", "%#{input}%")
    # User.where("CONCAT_WS(' ', name, surname) LIKE ?", "%#{input}%").or(User.where("CONCAT_WS(' ', surname, name) LIKE ?", "%#{input}%"))
  }

  validates :name, presence: true
  validates :surname, presence: true
  validates :password, format: { with: /\A.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/}
  validates :password_confirmation, format: { with: /\A.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/}
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}

  def get_avatar
    # if self.avatar.nil?
    if self.avatar.url.nil?
      'https://miro.medium.com/max/800/0*QCRunR_VjAIrvkjC.png'
    else
      self.avatar.url

    end
  end

  def has_like_on? type
    type.likes.where(user_id: self.id).exists?
  end



end