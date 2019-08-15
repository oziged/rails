class AddImagesToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post, :json
  end
end
