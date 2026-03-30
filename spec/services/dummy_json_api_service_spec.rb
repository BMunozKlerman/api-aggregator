require 'rails_helper'

RSpec.describe DummyJsonApiService, type: :service do
  describe '.get_user' do
    it 'fetches user data successfully' do
      user_id = 1
      response = DummyJsonApiService.get_user(user_id)
      expect(response).to be_a(Hash)
      expect(response['id']).to eq(user_id)
    end

    it 'returns nil for non-existent user' do
      user_id = -9999
      response = DummyJsonApiService.get_user(user_id)
      expect(response).to be_nil
    end
  end
  
  describe '.get_user_todos' do
    it 'fetches user todos successfully' do
      user_id = 1
      response = DummyJsonApiService.get_user_todos(user_id)
      expect(response).to be_a(Hash)
      expect(response['todos']).to be_an(Array)
    end

    it 'returns nil for non-existent user todos' do
      user_id = -9999
      response = DummyJsonApiService.get_user_todos(user_id)
      expect(response).to be_nil
    end
  end
end