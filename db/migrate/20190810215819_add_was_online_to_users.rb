class AddWasOnlineToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :was_online, :string
  end
end
