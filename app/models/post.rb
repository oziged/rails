class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: { message: 'Заголовок поста не может быть пустым.'}
  validates :body, presence: { message: 'Содержание поста не может быть пустым.'}
end
