class AddLikeableToLike < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :likeable_type, :string
    add_column :likes, :likeable_id, :integer
  end
end
