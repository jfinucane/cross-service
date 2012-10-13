class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.integer :gridtype
      t.integer :orient
      t.integer :nth
      t.string :word_id
    end
  end
end
