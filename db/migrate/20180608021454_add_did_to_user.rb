class AddDidToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :did, :string
  end
end
