class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :category1_id, null:false
      t.integer :category2_id, null:false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
