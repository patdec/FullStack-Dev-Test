# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Countries', type: :request do
  describe 'GET /index' do
    let!(:country) { FactoryBot.create(:country) }

    it 'returns http success' do
      get '/countries'
      expect(response).to have_http_status(:success)
    end

    it 'returns country FR' do
      get '/countries'
      expect(JSON.parse(response.body)).to eq('countries' => ['id' => country.id, 'name' => 'France', 'iso' => 'FR'])
    end
  end

end
