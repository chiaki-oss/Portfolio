class CreatePrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :prefectures do |t|

      t.integer :area_id, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_index :prefectures, :name, unique: true
  end
end
