class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :list, index: true, foreign_key: true
      t.string     :action
    end
  end
end
