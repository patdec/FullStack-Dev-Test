class Address < ApplicationRecord
  belongs_to :country

  validates :street, presence: true, length: { maximum: 255 }, allow_blank: false
  validates :city, presence: true, length: { maximum: 100 }, allow_blank:  false
  validates :zipcode, presence: true, length: { maximum: 20 }, allow_blank: false
  validates :country_id, presence: true
end
