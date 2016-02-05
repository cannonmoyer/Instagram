class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.text :ig_user_id

      t.timestamps null: false
    end
  end
end
