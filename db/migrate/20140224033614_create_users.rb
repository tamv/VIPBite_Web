class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :userId
      t.string      :userEmail
      t.string      :firstname
      t.string      :lastname
      t.string      :password
      t.datetime    :expDate
      t.boolean     :isAdmin
      t.timestamps
    end
  end
end
