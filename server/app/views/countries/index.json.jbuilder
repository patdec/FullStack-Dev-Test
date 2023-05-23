# frozen_string_literal: true

json.countries @countries do |country|
  json.id country.id
  json.name country.name
  json.iso country.iso
end
