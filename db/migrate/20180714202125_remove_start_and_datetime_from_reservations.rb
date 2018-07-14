class RemoveStartAndDatetimeFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :start, :string
    remove_column :reservations, :datetime, :string
  end
end
