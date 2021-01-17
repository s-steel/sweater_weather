require 'rails_helper'

RSpec.describe 'User Register', type: :request do
  describe 'POST /api/v1/users' do
    it 'can register the user and return their api key' do
      post '/api/v1/users', headers: { 'Content-Type' => 'application/json',
                                       'Accept' => 'application/json' }, body: {
                                         "email": 'whatever@example.com',
                                         "password": 'password',
                                         "password_confirmation": 'password'
                                       }
      expect(response).to be_successful
      expect(response).to have_http_status(201)
      user_reponse = JSON.parse(response.body, symbolize_names: true)
      user_data = user_reponse[:data][:attributes]
      user = User.last

      expect(user.email).to eq(user_data[:email])
      expect(user.api_key).to eq(user_data[:api_key])
    end
  end
end
