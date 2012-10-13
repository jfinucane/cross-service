class CreateGridTypes < ActiveRecord::Migration
  def change
    create_table :grid_types do |t|
      t.integer :dictionary_id
      t.integer :row_count
      t.integer :col_count
      t.text :status
      t.timestamps
    end
  end
end
