class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :reservation,    null: false, foreign_key: true
      t.references :user,           null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :payjp_token, null: false
      t.timestamps
    end
  end
end
