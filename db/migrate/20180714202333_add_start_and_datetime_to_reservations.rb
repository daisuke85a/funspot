class AddStartAndDatetimeToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :start, :datetime
  end
end
