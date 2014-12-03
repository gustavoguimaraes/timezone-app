class Zone < ActiveRecord::Base
  validates :name, presence: true
  validates :city_name, presence: true
  validates :minutes_offset, presence: true, numericality: true
  belongs_to :user

end
