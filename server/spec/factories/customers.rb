# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { 'Dupont' }
    email { 'dupont@orange.fr' }
    phone { '0604042302' }
  end
end
