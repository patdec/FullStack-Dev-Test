# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Installations', type: :request do
  describe 'POST /installations' do
    let(:country) { FactoryBot.create(:country) }
    let(:installer) { FactoryBot.create(:installer) }
    let(:params) do
      {
        installation: {
          installer_id: installer.id,
          panels_type: 'hybrid',
          panels_number: 8,
          panels_ids: (1..8).map { |n| "12300#{n}" },
          customer_attributes: { name: 'Pyrus', email: 'pyrus@orange.fr', phone: '0678342398' },
          address_attributes: { street: '1, place de la Comédie', zipcode: '75001', city: 'Paris', country_id: country.id }
        }
      }
    end

    context 'when all fields are provided with valid values' do
      it 'creates an installation' do
        expect { post installations_path, params: params }.to change(Installation, :count).by(1)
      end

      it 'returns a 200' do
        post installations_path, params: params
        expect(response).to have_http_status(:created)
      end
    end

    context 'when installer_id is not provided' do
      before { params[:installation][:installer_id] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['installer']).to eq(['must exist'])
      end
    end

    context 'when panels_type is not provided' do
      before { params[:installation][:panels_type] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['panels_type']).to eq(["can't be blank"])
      end
    end

    context 'when panels_number is not provided' do
      before { params[:installation][:panels_number] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['panels_number']).to eq(["can't be blank", 'is not a number'])
      end
    end

    context 'when panels_ids is not provided' do
      before { params[:installation][:panels_ids] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['panels_ids']).to eq(["can't be blank", "length can't be different than panels_number"])
      end
    end

    context 'when panels_ids length is less than panels_number' do
      before { params[:installation][:panels_ids] = (1..7).map { |n| "12300#{n}" } }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['panels_ids']).to eq(["length can't be different than panels_number"])
      end
    end

    context 'when one panels_id has wrong format' do
      before { params[:installation][:panels_ids] = (1..7).map { |n| "12300#{n}" }.push('x' * 6) }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['panels_ids']).to eq(['format id must be 6 digits'])
      end
    end

    context 'when customer email is missing' do
      before { params[:installation][:customer_attributes][:email] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['customer.email']).to include("can't be blank")
      end
    end

    context 'when address city is missing' do
      before { params[:installation][:address_attributes][:city] = nil }

      it 'returns a 500' do
        post installations_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a related error message' do
        post installations_path, params: params
        expect(JSON.parse(response.body)['error']['address.city']).to include("can't be blank")
      end
    end
  end
end
