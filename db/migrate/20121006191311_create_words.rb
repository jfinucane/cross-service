class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.text :word
      t.integer :dictionary_id
      t.integer :processed 
    end
  end
end
