# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  let(:country) { FactoryBot.create(:country) }

  describe 'country creation' do
    before { country.save }

    it 'is valid' do
      expect(country).to be_valid
    end

    it 'saves properties' do
      expect(country.id).to be_instance_of Integer
    end
  end
end
