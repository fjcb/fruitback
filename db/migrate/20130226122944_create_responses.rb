class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :text

      t.timestamps null: false
      
      t.references :idea, null: false
      
      t.references :user, null: false
      
      t.references :state, null: false
    end
    
    change_table :responses do |t|
      t.index :idea_id
      t.foreign_key :ideas, :dependent => :delete
      
      t.index :user_id
      t.foreign_key :users, :dependent => :delete
      
      t.index :state_id
    end
    
  end
end
