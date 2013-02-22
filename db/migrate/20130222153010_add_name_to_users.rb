class AddNameToUsers < ActiveRecord::Migration
  
  def change
    
    change_table :users do |t|
      t.string :name, :default => "", :null => false
    end

  end
  
end