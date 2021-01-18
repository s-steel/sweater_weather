require 'rails_helper'

RSpec.describe 'User Login', type: :request do
  describe 'POST /api/v1/sessions' do
    it 'can register the user and return their api key' do
      user = User.create!(email: 'test@email.com',
        password: 'password',
        password_confirmation: 'password')

      post '/api/v1/users', params: {
        "email": 'test@example.com',
        "password": 'password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                                       'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      user_response = JSON.parse(response.body, symbolize_names: true)
      user_data = user_response[:data][:attributes]

      expect(user_response[:data][:type]).to eq('user')
      expect(user_response[:data][:id]).to eq(user.id.to_s)
      expect(user.email).to eq(user_data[:email])
      expect(user.api_key).to eq(user_data[:api_key])
    end
  end
end
