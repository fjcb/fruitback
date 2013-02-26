class AddStateToResponse < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.references :state
      t.index :state_id
    end
  end
end
