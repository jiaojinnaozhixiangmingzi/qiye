class CreateUserCardLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_card_logs do |t|
      t.integer :kind, default: 0
      t.float :real_money, default: 0
      t.float :fake_money, default: 0
      t.string :loggable_type
      t.integer :loggable_id
      t.references :user_card

      t.timestamps
    end

    add_index :user_card_logs, [:loggable_type, :loggable_id]
  end
end
