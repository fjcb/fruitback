class AddUserToVotes < ActiveRecord::Migration
  
  def change
    change_table :votes do |t|
      t.references :user
      t.index :user_id
    end
    
    change_table :user do |t|
      t.foreign_key :votes, :dependent => :set_null
    end
  end
  
end
