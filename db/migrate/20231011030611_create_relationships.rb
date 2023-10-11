class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :following, null: false
      t.references :follower, null: false
      t.timestamps
    end
  end
end
