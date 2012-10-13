class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.text :name
      t.text :attribution

      t.timestamps
    end
  end
end
