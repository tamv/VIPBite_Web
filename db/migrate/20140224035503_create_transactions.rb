class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :identifier
      t.string :userId
      t.string :subsription
      t.string :billingAddress

      t.timestamps
    end
  end
end
