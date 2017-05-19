class CreateFactoryProcessRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :factory_process_records do |t|
      t.references :factory, foreign_key: true
      t.references :category, foreign_key: true
      t.references :product, foreign_key: true
      t.date :process_on
      t.integer :amount, default: 0
    end
  end
end
