# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Installer, type: :model do
  let(:installer) { FactoryBot.build(:installer) }

  describe 'installer creation' do
    before { installer.save }

    it 'is valid' do
      expect(installer).to be_valid
    end

    it 'saves properties' do
      expect(installer.id).to be_instance_of Integer
    end
  end

  describe 'name validations' do
    context 'when name is too long' do
      before { installer.name = 'x' * 256 }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when name is blank' do
      before { installer.name = '' }

      it 'is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when name is nil' do
      before { installer.name = nil }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end
  end

  describe 'siren validations' do
    context 'when email is too long' do
      before { installer.siren = '1' * 10 }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when siren is blank' do
      before { installer.siren = '' }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when siren is nil' do
      before { installer.siren = nil }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when siren has wrong format' do
      before { installer.siren = 'aaa234456' }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end

    context 'when siren is not uniq' do
      before { FactoryBot.create(:installer, name: 'SA Sun Panels') }

      it 'installer is not valid' do
        expect(installer).not_to be_valid
      end
    end
  end
end
