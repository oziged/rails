class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true

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