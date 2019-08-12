class AddInfoToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
  end
end
