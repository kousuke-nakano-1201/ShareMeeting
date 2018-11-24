class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :menber, foreign_key: true
      t.references :follow, foreign_key: { to_table: :menbers }

      t.timestamps
      
      t.index [:menber_id, :follow_id], unique: true
    end
  end
end
