class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string  :name
      t.integer :author_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
