class AddUserIdToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :user_id, :integer
    add_index :events, :user_id
  end
end
