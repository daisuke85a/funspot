class CreateRegularreservations < ActiveRecord::Migration
  def change
    create_table :regularreservations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :myfunspot, index: true, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.integer :dow

      t.timestamps null: false
    end
  end
end
