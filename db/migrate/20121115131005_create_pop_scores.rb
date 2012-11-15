class CreatePopScores < ActiveRecord::Migration
  def change
    create_table :pop_scores do |t|
      t.text :word
      t.integer :score
      t.integer :dictionary_id
    end
  end
end
