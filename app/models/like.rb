class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def get_post_author
    if self.likeable.class != Post
      self.likeable.get_post_author
    else
      User.find(self.likeable.user_id)
    end
  end
end

