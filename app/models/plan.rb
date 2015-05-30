class Plan < ActiveRecord::Base
  belongs_to :area
  belongs_to :category
  belongs_to :user
  has_many :days
  has_one :booking
end
