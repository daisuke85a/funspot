class CreateMyfunspots < ActiveRecord::Migration
  def change
    create_table :myfunspots do |t|
      t.string :name
      t.text :content
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :website
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
