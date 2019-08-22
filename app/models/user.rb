class User < ApplicationRecord
  before_create :confirmation_token

  mount_uploader :avatar, ImagesUploader

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password

  scope :search_by_fullname, -> (input) {
    input = input.split(' ').map { |word| word.capitalize }.join(' ')
    User.where("CONCAT_WS(' ', name, surname) LIKE ? or CONCAT_WS(' ', surname, name) LIKE ?", "%#{input}%", "%#{input}%")
    # User.where("CONCAT_WS(' ', name, surname) LIKE ?", "%#{input}%").or(User.where("CONCAT_WS(' ', surname, name) LIKE ?", "%#{input}%"))
  }

  validates :name, presence: true
  validates :surname, presence: true
  validates :password, format: {with: /\A.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/}
  validates :password_confirmation, format: {with: /\A.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/}
  validates :email, uniqueness: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}

  def self.find_or_create_from_auth_hash(auth_hash)
    p '*' * 100
    p auth_hash
    p '*' * 100
    return nil if auth_hash.nil?
    user = User.where(provider: auth_hash.provider, uid: auth_hash.uid).first
    user = User.new(provider: auth_hash.provider, uid: auth_hash.uid) if user.nil?
    if auth_hash.provider == 'facebook'
      user.update(
          name: user.name || auth_hash.info.name.split(' ')[0],
          surname: user.surname || auth_hash.info.name.split(' ')[1],
          email: auth_hash.uid + auth_hash.provider + '@gmail.com',
          password: auth_hash.provider + auth_hash.uid + auth_hash.info.name.upcase,
          password_confirmation: auth_hash.provider + auth_hash.uid + auth_hash.info.name.upcase,
          was_online: Time.now,
          provider_img: auth_hash.info.image + '?type=large&width=400&height=400'
      )
    elsif auth_hash.provider == 'linkedin'
      user.update(
          name: user.name || auth_hash.info.first_name,
          surname: user.surname || auth_hash.info.last_name,
          email: auth_hash.uid + auth_hash.provider + '@gmail.com',
          password: auth_hash.provider + auth_hash.uid + auth_hash.info.first_name.upcase + '1',
          password_confirmation: auth_hash.provider + auth_hash.uid + auth_hash.info.first_name.upcase + '1',
          was_online: Time.now,
          provider_img: auth_hash.info.picture_url
      )
    end
    user.update(email_confirmed: true)
    user
  end

  def get_avatar
    if self.avatar.url.nil? && self.provider_img.nil?
      'https://miro.medium.com/max/800/0*QCRunR_VjAIrvkjC.png'
    elsif self.avatar.url.nil?
      self.provider_img
    else
      self.avatar.url
    end
  end


  def has_like_on? type
    type.likes.where(user_id: self.id).exists?
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end