class CreateComments < ActiveRecord::Migration
  def change
    
    create_table :comments do |t|
      t.text :text, :null => false

      t.timestamps null: false
      
      t.references :idea, null: false
      
      t.references :user, null: false
    end
    
    change_table :comments do |t|
      t.index :idea_id
      t.foreign_key :ideas, :dependent => :delete
      
      t.index :user_id
      t.foreign_key :users, :dependent => :delete
    end
    
    
  end
end
