class Plan < ActiveRecord::Base
  belongs_to :area
  belongs_to :category
  belongs_to :user
  has_many :days
  has_one :booking
  accepts_nested_attributes_for :days, allow_destroy: true
  mount_uploader :image, ImageUploader

  validates_length_of :title, :in => (3..32)
  validates_presence_of :image,:body
  validates_numericality_of :amount
end
