class CreateLevenhoods < ActiveRecord::Migration
  def change
    create_table :levenhoods do |t|
      t.text :neighbor
      t.text :words
      t.integer :dictionary_id
    end
    add_index('levenhoods', 'neighbor')
  end
end
