require 'rails_helper'

RSpec.describe UserStatusService, type: :service do
  describe '.call' do
    it 'fetches user data and todos successfully' do
      user_id = "1"
      allow(DummyJsonApiClient).to receive(:get_user).and_return({
        'firstName' => 'John', 'lastName' => 'Doe', 'age' => 30
      })
      allow(DummyJsonApiClient).to receive(:get_user_todos).and_return({
        'todos' => [{ 'completed' => false, 'todo' => 'Task 1' }]
      })
      result = UserStatusService.new(user_id).get_user

      expect(result).to be_a(UserStatus)
      expect(result[:full_name]).to be_a(String)
      expect(result[:experience]).to be_a(String)
      expect(result[:pending_task_count]).to be_a(Integer)
      expect(result[:next_urgent_task]).to be_a(String).or be_nil
    end

    it 'returns an error hash for non-existent user' do
      user_id = "9999999"
      mock_response = double('response', success?: false, message: 'Not Found')
      allow(HTTParty).to receive(:get).and_return(mock_response)
      result = UserStatusService.new(user_id).get_user

      expect(result).to be_a(Hash)
      expect(result[:error]).to be_present
    end
  end
end
