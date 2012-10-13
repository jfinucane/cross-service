class CreateAnagrams < ActiveRecord::Migration
  def change
    create_table :anagrams do |t|
      t.integer :sorted_id
      t.integer :word_id
    end
  end
end
