require 'rails_helper'

RSpec.describe DummyJsonApiClient, type: :Client do
  describe '.get_user' do
    it 'fetches user data successfully' do
      user_id = 1
      mock_response = double('response', success?: true, parsed_response: { 'id' => user_id })
      allow(HTTParty).to receive(:get).and_return(mock_response)
      response = DummyJsonApiClient.get_user(user_id)
      expect(response).to be_a(Hash)
      expect(response['id']).to eq(user_id)
    end

    it 'raises an error for non-existent user' do
      user_id = -9999
      mock_response = double('response', success?: false, message: 'Not Found')
      allow(HTTParty).to receive(:get).and_return(mock_response)
      expect { DummyJsonApiClient.get_user(user_id) }.to raise_error(StandardError)
    end
  end

  describe '.get_user_todos' do
    it 'fetches user todos successfully' do
      user_id = 1
      mock_response = double('response', success?: true, parsed_response: { 'todos' => [] })
      allow(HTTParty).to receive(:get).and_return(mock_response)
      response = DummyJsonApiClient.get_user_todos(user_id)
      expect(response).to be_a(Hash)
      expect(response['todos']).to be_an(Array)
    end

    it 'raises an error for non-existent user todos' do
      user_id = -9999
      mock_response = double('response', success?: false, message: 'Not Found')
      allow(HTTParty).to receive(:get).and_return(mock_response)
      expect { DummyJsonApiClient.get_user_todos(user_id) }.to raise_error(StandardError)
    end
  end
end
