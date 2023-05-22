# frozen_string_literal: true

FactoryBot.define do
  factory :installation do
    panels_number { 8 }
    panels_type  { :hybrid }
    panels_ids { (1..8).to_a.map { |id| "12300#{id}" } }
  end
end
