require 'rails_helper'

RSpec.describe FetchUserDataService, type: :service do
  describe '.call' do
    it 'fetches user data and todos successfully' do
      user_id = 2
      result = FetchUserDataService.new(user_id).call
      
      expect(result).to be_a(Hash)
      expect(result[:full_name]).to be_a(String)
      expect(result[:experience]).to be_a(String)
      expect(result[:pending_task_count]).to be_a(Integer)
      expect(result[:next_urgent_task]).to be_a(String).or be_nil
    end

    it 'returns nil for non-existent user' do
      user_id = -9999
      result = FetchUserDataService.new(user_id).call
      
      expect(result).to be_nil
    end
  end
end