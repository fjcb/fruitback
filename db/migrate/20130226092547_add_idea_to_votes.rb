class AddIdeaToVotes < ActiveRecord::Migration
  
  def change
    change_table :votes do |t|
      t.references :idea
      t.index :idea_id
    end
    
    change_table :idea do |t|
      t.foreign_key :votes, :dependent => :set_null
    end
  end
  
end