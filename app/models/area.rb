class Area < ActiveRecord::Base
  has_many :plans
  geocoded_by :name
  after_validation :geocode
  validates_length_of :name, :in => 1..16

end