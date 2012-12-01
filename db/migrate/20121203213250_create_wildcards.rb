class CreateWildcards < ActiveRecord::Migration
  def change
    create_table :wildcards do |t|
      t.text :word
      t.text :words
      t.integer :dictionary_id
    end
    add_index('wildcards', 'word')
  end
end
