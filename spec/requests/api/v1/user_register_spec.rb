require 'rails_helper'

RSpec.describe 'User Register', type: :request do
  describe 'POST /api/v1/users' do
    it 'can register the user and return their api key' do
      post '/api/v1/users', params: {
        "email": 'test@example.com',
        "password": 'password',
        "password_confirmation": 'password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                                       'Accept' => 'application/json' }
      expect(response).to be_successful
      expect(response).to have_http_status(201)
      user_response = JSON.parse(response.body, symbolize_names: true)
      user_data = user_response[:data][:attributes]
      user = User.last

      expect(user_response[:data][:type]).to eq('user')
      expect(user_response[:data][:id]).to eq(user.id.to_s)
      expect(user.email).to eq(user_data[:email])
      expect(user.api_key).to eq(user_data[:api_key])
    end

    it 'error with invalid email' do
      user = User.create!(email: 'tester@email.com',
                          password: 'password',
                          password_confirmation: 'password')
      post '/api/v1/users', params: {
        "email": 'tester@email.com',
        "password": 'password',
        "password_confirmation": 'password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                                        'Accept' => 'application/json' } 
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Email has already been taken')
    end

    it 'error with invalid password' do
      post '/api/v1/users', params: {
      "email": 'tester@email.com',
      "password": 'password',
      "password_confirmation": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Password confirmation doesn\'t match Password')
    end

    it 'error with invalid email and password' do
      user = User.create!(email: 'tester@email.com',
        password: 'password',
        password_confirmation: 'password')
      post '/api/v1/users', params: {
      "email": 'tester@email.com',
      "password": 'password',
      "password_confirmation": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Email has already been taken, Password confirmation doesn\'t match Password')
    end

    it 'error with blank email' do
      post '/api/v1/users', params: {
      "email": '',
      "password": 'password',
      "password_confirmation": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Email can\'t be blank')
    end

    it 'error with blank password' do
      post '/api/v1/users', params: {
      "email": 'tester@email.com',
      "password": '',
      "password_confirmation": 'Password'
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Password digest can\'t be blank')
    end

    it 'error with blank password' do
      post '/api/v1/users', params: {
      "email": 'tester@email.com',
      "password": 'password',
      "password_confirmation": ''
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      expect(response.body).to match('Validation failed: Password confirmation doesn\'t match Password, Password confirmation can\'t be blank')
    end
  end
end
