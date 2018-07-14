class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :myfunspot, index: true, foreign_key: true
      t.string :start
      t.string :datetime
      t.datetime :end

      t.timestamps null: false
    end
  end
end
