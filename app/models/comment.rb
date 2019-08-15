class Comment < ApplicationRecord
  mount_uploaders :images, ImagesUploader

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy, as: :likeable

  def get_post_author
    if self.commentable.class != Post
      self.commentable.get_post_author
    else
      User.find(self.commentable.user_id)
    end
  end
end
