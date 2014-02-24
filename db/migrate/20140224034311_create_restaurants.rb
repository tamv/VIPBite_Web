class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.serial    :identifier
      t.string    :name
      t.string    :address
      t.string    :city
      t.string    :province
      t.string    :postal
      t.string    :imageUrl
      t.string    :email
      t.string    :phone
      t.string    :VIPBiteDeal
      t.float     :longitude
      t.float     :latitude
      t.string    :detailId
      t.string    :search
      t.datetime  :modifiedDate

      t.timestamps
    end
  end
end
