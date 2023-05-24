# frozen_string_literal: true

class Installation < ApplicationRecord
  PANEL_ID_REGEX = /\A\d{6}\z/.freeze

  enum panels_type: { photovoltaic: 0, hybrid: 1 }
  enum install_state: { waiting: 0, in_progress: 1, completed: 2 }

  belongs_to :customer
  belongs_to :installer
  belongs_to :address

  validates :panels_number, presence: true, numericality: { greater_than: 0, less_than: 50 }
  validates :panels_type, presence: true
  validates :panels_ids, presence: true
  validates :date, presence: true
  validate :check_panels_ids_number, :check_panels_ids_format

  accepts_nested_attributes_for :customer, :address

  private

  def check_panels_ids_number
    return if panels_ids.nil? || panels_ids.length == panels_number

    errors.add(:panels_ids, "length can't be different than panels_number")
  end

  def check_panels_ids_format
    return if panels_ids.nil? || !panels_ids.find { |id| !PANEL_ID_REGEX.match id }

    errors.add(:panels_ids, 'format id must be 6 digits')
  end
end
