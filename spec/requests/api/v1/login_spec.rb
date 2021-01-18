require 'rails_helper'

RSpec.describe 'User Login', type: :request do
  describe 'POST /api/v1/sessions' do
    before :each do
      @user = User.create!(email: 'test@example.com',
                           password: 'password',
                           password_confirmation: 'password')
    end

    it 'can login the user and return their api key' do
      post '/api/v1/sessions', params: {
        "email": 'test@example.com',
        "password": 'password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      user_response = JSON.parse(response.body, symbolize_names: true)
      user_data = user_response[:data][:attributes]

      expect(user_response[:data][:type]).to eq('user')
      expect(user_response[:data][:id]).to eq(@user.id.to_s)
      expect(@user.email).to eq(user_data[:email])
      expect(@user.api_key).to eq(user_data[:api_key])
    end

    it 'cant login a user who hasnt registered yet' do
      post '/api/v1/sessions', params: {
        "email": 'notregistered@example.com',
        "password": 'password1'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }

      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find User')
    end

    it 'cant login a user with invalid password' do
      post '/api/v1/sessions', params: {
        "email": 'test@example.com',
        "password": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(401)
      expect(response.body).to match('Invalid email or password, please try again.')
    end

    it 'cant login a user with missing email field' do
      post '/api/v1/sessions', params: {
        "email": '',
        "password": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(404)
      expect(response.body).to match('Couldn\'t find User')
    end
  end
end
