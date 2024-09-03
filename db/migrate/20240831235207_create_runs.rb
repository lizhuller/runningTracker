class CreateRuns < ActiveRecord::Migration[7.2]
  def change
    create_table :runs do |t|
      t.datetime :date
      t.float :miles
      t.integer :hours
      t.integer :minutes
      t.string :shoe

      t.timestamps
    end
  end
end
