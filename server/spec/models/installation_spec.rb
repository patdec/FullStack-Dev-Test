# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Installation, type: :model do
  let(:country) { FactoryBot.create(:country) }
  let(:address) { FactoryBot.create(:address, country: country) }
  let(:installer) { FactoryBot.create(:installer) }
  let(:customer) { FactoryBot.create(:customer) }
  let(:installation) { FactoryBot.build(:installation, installer: installer, customer: customer, address: address) }

  describe 'installation creation' do
    before { installation.save }

    it 'is valid' do
      expect(installation).to be_valid
    end

    it 'saves properties' do
      expect(installation.id).to be_instance_of Integer
    end

    it 'saves panel ids' do
      expect(installation.panels_ids).to eq (1..8).map { |n| "12300#{n}" }
    end

    it 'saves panel type' do
      expect(installation.panels_type).to eq 'hybrid'
    end
  end

  describe 'panels_number validations' do
    context 'when number is too high' do
      before { installation.panels_number = 51 }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end

    context 'when number is 0' do
      before { installation.panels_number = 0 }

      it 'is not valid' do
        expect(installation).not_to be_valid
      end
    end

    context 'when number is nil' do
      before { installation.panels_number = nil }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'panels_type validations' do
    context 'when type does not exist' do
      it 'installation is not valid' do
        expect { installation.panels_type = :toto }.to raise_error(ArgumentError).with_message(/is not a valid panels_type/)
      end
    end

    context 'when type is nil' do
      before { installation.panels_type = nil }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'panels_ids validations' do
    context 'when ids is not provided' do
      before { installation.panels_ids = [] }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end

    context 'when panels_ids is nil' do
      before { installation.panels_ids = nil }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end

    context 'when panels_ids length is different than panels_number' do
      before { installation.panels_number = 7 }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end

    context 'when one panel id has not the right format' do
      before { installation.panels_ids = installation.panels_ids.slice(0, 7).push('12345') }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'customer_id validations' do
    context 'when customer_id is null' do
      before { installation.customer_id = nil }

      it 'customer_id is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'installer_id validations' do
    context 'when installer_id is null' do
      before { installation.installer_id = nil }

      it 'customer_id is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'address_id validations' do
    context 'when address_id is null' do
      before { installation.address_id = nil }

      it 'customer_id is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

  describe 'date validations' do
    context 'when date is nil' do
      before { installation.date = nil }

      it 'installation is not valid' do
        expect(installation).not_to be_valid
      end
    end
  end

end
