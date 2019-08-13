class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password
  validates :name, presence: true
  validates :surname, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "form is incorrect" }

  def avatar
    'https://miro.medium.com/max/800/0*QCRunR_VjAIrvkjC.png'
  end

  def online # shows when user was online
    was_online = DateTime.parse(self.was_online).to_i
    now = DateTime.now.to_i
    offline = now - was_online
    if offline < 300
      'online'
    else
      if offline < 3600
        "#{offline/60} минут назад"
      elsif offline < 86400
        puts '////////////////////////'
        p self
        puts '////////////////////////'
        "#{offline/3600} часов назад"
      else
        "#{Time.at(was_online).to_s[0..-16]}"
      end
    end
  end

  # def can_change item
  #   if item[:user_id] == current_user.id
  #     return true
  #   else
  #     false
  #   end
  # end
end