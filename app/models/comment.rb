class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  def get_post_author
    if self.commentable.class != Post
      self.commentable.get_post_author
    else
      return User.find(self.commentable.user_id)
    end
  end
end
