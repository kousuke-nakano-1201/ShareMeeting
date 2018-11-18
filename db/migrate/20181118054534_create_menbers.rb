class CreateMenbers < ActiveRecord::Migration[5.0]
  def change
    create_table :menbers do |t|
      t.string :name
      t.boolean :attend, :default => true

      t.timestamps
    end
  end
end
