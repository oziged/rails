class AddDataToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :data, :string
  end
end
