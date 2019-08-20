class AddProviderImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider_img, :string
  end
end
