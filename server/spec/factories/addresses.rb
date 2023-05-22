# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { '1, rue de lq République' }
    zipcode { '69001' }
    city { 'Lyon' }
  end
end
