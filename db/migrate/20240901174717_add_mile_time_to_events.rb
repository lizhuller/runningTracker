class AddMileTimeToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :mile_time, :time
  end
end
