class AddResponsesToIdea < ActiveRecord::Migration
  
  def change
    change_table :responses do |t|
      t.references :idea
      t.index :idea_id
    end
    
    change_table :idea do |t|
      t.foreign_key :responses, :dependent => :set_null
    end
  end
  
end
