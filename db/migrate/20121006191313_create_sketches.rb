class CreateSketches < ActiveRecord::Migration
  def change
    create_table :sketches do |t|
      t.integer :gridtype
      t.string  :sketch
    end
  end
end
