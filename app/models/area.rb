class Area < ActiveRecord::Base
  has_many :plans
  validates_length_of :name, :in => 3..16
end