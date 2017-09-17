class CreateShorteners < ActiveRecord::Migration[5.1]
  def change
    create_table :shorteners do |t|

      t.string  :target
      t.string  :dilute
      t.integer :hits

      t.timestamps
    end
  end
end
