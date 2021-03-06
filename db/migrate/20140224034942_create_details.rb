class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details, identifier: :serial do |t|
      t.integer   :identifier
      t.text      :VIPBiteDeal
      t.text      :dealDetail
      t.string    :reservation
      t.string    :operatinghour
      t.string    :link
      t.text      :comment
      t.string    :imageFolder
      t.string    :urbanspoonLink
      t.string    :urbanspoonReview

      t.timestamps
    end
  end
end
