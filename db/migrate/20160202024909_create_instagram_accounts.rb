class CreateInstagramAccounts < ActiveRecord::Migration
  def change
    create_table :instagram_accounts do |t|
      t.string :username
      t.text :auth_token
      t.text :ig_id
      t.text :profile_picture

      t.timestamps null: false
    end
  end
end
