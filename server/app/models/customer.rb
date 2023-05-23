# frozen_string_literal: true

class Customer < ApplicationRecord
  EMAIL_REGEXP = /\A[a-z0-9-]+@[a-z0-9-]+\.[a-z]{2,}\z/i.freeze

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }, allow_blank: false, format: EMAIL_REGEXP
  validates :phone, phone: true

  delegate :street, :city, :zipcode, :country_id, to: :address
end
