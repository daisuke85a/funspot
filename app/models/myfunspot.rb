class Myfunspot < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

end
