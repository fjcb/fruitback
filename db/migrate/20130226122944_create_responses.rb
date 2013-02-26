class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :text

      t.timestamps
    end
  end
end
