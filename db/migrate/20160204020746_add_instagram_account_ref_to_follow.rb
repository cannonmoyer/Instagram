class AddInstagramAccountRefToFollow < ActiveRecord::Migration
  def change
    add_reference :follows, :instagram_account, index: true, foreign_key: true
  end
end
