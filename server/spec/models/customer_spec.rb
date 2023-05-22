# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { FactoryBot.build(:customer) }

  describe 'customer creation' do
    before { customer.save }

    it 'is valid' do
      expect(customer).to be_valid
    end

    it 'saves properties' do
      expect(customer.id).to be_instance_of Integer
    end
  end

  describe 'name validations' do
    context 'when name is too long' do
      before { customer.name = 'x' * 256 }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when name is blank' do
      before { customer.name = '' }

      it 'is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when name is nil' do
      before { customer.name = nil }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end
  end

  describe 'email validations' do
    context 'when email is too long' do
      before { customer.email = "#{'x' * 256}@orange.fr" }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when email is blank' do
      before { customer.email = '' }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when email is nil' do
      before { customer.email = nil }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when email has wrong format' do
      before { customer.email = 'dupont-orange.fr' }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when email is not uniq' do
      before { FactoryBot.create(:customer, name: 'Durant', phone: '0734230394') }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end
  end

  describe 'phone validations' do
    context 'when phone has alpha chars' do
      before { customer.phone = '06aa984909' }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when phone is blank' do
      before { customer.phone = '' }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end

    context 'when phone is nil' do
      before { customer.phone = nil }

      it 'customer is not valid' do
        expect(customer).not_to be_valid
      end
    end
  end
end
