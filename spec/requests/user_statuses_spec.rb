require 'rails_helper'

RSpec.describe "UserStatuses", type: :request do
  let(:valid_token) { "test_token_123" }
  let(:headers) { { "X-Api-Key" => valid_token } }

  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:fetch).and_call_original

    allow(ENV).to receive(:[]).with("API_KEY").and_return(valid_token)
    allow(ENV).to receive(:fetch).with("API_KEY", anything).and_return(valid_token)
  end

  describe "GET show" do
    it "returns http success" do
      get "/user_status/1", headers: headers
      data = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(data).not_to have_key('created_at')
      expect(data).not_to have_key('updated_at')
      expect(data).to have_key('id')
      expect(data).to have_key('full_name')
      expect(data).to have_key('experience')
      expect(data).to have_key('pending_task_count')
      expect(data).to have_key('next_urgent_task')
    end

    it "returns unauthorized without token" do
      get "/user_status/1"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
