# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:country) { FactoryBot.create(:country) }
  let(:address) { FactoryBot.build(:address, country: country) }

  describe 'address creation' do
    before { address.save }

    it 'is valid' do
      expect(address).to be_valid
    end

    it 'saves properties' do
      expect(address.id).to be_instance_of Integer
    end
  end

  describe 'street validations' do
    context 'when street is too long' do
      before { address.street = 'x' * 256 }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when street is blank' do
      before { address.street = '' }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when street is nil' do
      before { address.street = nil }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end
  end

  describe 'zipcode validations' do
    context 'when zipcode is too long' do
      before { address.zipcode = 'x' * 21 }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when zipcode is blank' do
      before { address.zipcode = '' }

      it 'zipcode is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when zipcode is nil' do
      before { address.zipcode = nil }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end
  end

  describe 'city validations' do
    context 'when city is too long' do
      before { address.city = 'x' * 101 }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when city is blank' do
      before { address.city = '' }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end

    context 'when city is nil' do
      before { address.city = nil }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end
  end

  describe 'country validations' do
    context 'when country_id is nil' do
      before { address.country_id = nil }

      it 'address is not valid' do
        expect(address).not_to be_valid
      end
    end
  end
end
