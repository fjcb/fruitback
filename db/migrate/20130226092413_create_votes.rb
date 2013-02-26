class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :score, :default => 0, :null => false
      
      t.timestamps null: false
      
      t.references :idea, null: false
      
      t.references :user, null: false
    end
    
    change_table :votes do |t|
      t.index :idea_id
      t.foreign_key :ideas, :dependent => :delete
      
      t.index :user_id
      t.foreign_key :users, :dependent => :delete
    end
    
  end
end
