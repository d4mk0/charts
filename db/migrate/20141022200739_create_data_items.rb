class CreateDataItems < ActiveRecord::Migration
  def change
    create_table :data_items do |t|
      t.date :date
      t.string :store
      t.integer :rating
      t.string :status
      t.boolean :criterion

      t.timestamps
    end
  end
end
