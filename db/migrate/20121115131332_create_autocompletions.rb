class CreateAutocompletions < ActiveRecord::Migration
  def change
    create_table :autocompletions do |t|
      t.text :prefix
      t.text :words
      t.integer :dictionary_id
    end
    add_index('autocompletions', 'prefix', {:unique=>true})
  end
end
