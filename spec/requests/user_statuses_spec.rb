require 'rails_helper'

RSpec.describe "UserStatuses", type: :request do
  describe "GET show" do
    it "returns http success" do
      get "/user_status/1"
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
  end

end
