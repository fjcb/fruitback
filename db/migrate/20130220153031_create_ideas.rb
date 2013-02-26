class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.integer :score, :default => 0, :null => false

      t.timestamps null: false
    end
  end
end
