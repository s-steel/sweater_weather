require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presences_of :email }
    it { should validate_presences_of :password_digest }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :api_key }
  end
end
