class AddIdeasToSite < ActiveRecord::Migration

  def change
    change_table :ideas do |t|
      t.references :site
      t.index :site_id
    end
    
    change_table :ideas do |t|
      t.foreign_key :sites, :dependent => :set_null
    end
    
  end
  
end