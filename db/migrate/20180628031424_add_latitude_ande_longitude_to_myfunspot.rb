class AddLatitudeAndeLongitudeToMyfunspot < ActiveRecord::Migration
  def change
    add_column :myfunspots, :latitude, :float
    add_column :myfunspots, :longitude, :float
  end
end
