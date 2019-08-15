class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :likes, dependent: :destroy, as: :likeable


  validates :title, presence: { message: 'Заголовок поста не может быть пустым.'}
  validates :body, presence: { message: 'Содержание поста не может быть пустым.'}
end
