class AddCommentsToIdea < ActiveRecord::Migration

  def change
    change_table :comments do |t|
      t.references :idea
      t.index :idea_id
    end
    
    change_table :comments do |t|
      t.foreign_key :ideas, :dependent => :set_null
    end
    
  end
  
end