require 'rails_helper'

RSpec.describe 'Installers', type: :request do
  describe 'GET /index' do
    let!(:installer) { FactoryBot.create(:installer) }

    it 'returns http success' do
      get '/installers'
      expect(response).to have_http_status(:success)
    end

    it 'returns installer SA Solar Star' do
      get '/installers'
      expect(JSON.parse(response.body)).to eq('installers' => ['id' => installer.id, 'name' => 'SA Solar Star',
                                                              'siren' => '455093234'])
    end
  end

end
