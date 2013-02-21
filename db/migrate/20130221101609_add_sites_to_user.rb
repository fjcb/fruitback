class AddSitesToUser < ActiveRecord::Migration

  def change
    change_table :sites do |t|
      t.references :user
      t.index :user_id
    end
    
    change_table :sites do |t|
      t.foreign_key :users, :dependent => :set_null
    end
    
  end
  
end