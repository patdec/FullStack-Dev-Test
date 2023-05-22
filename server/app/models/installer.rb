# frozen_string_literal: true

class Installer < ApplicationRecord
  SIREN_REGEXP = /\A\d{9}\z/i.freeze

  has_many :installations, dependent: :destroy
  has_many :customers, through: :installations

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
  validates :siren, presence: true, uniqueness: true, length: { is: 9 }, allow_blank: false, format: SIREN_REGEXP
end
