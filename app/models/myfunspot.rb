class Myfunspot < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

end
