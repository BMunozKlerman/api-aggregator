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

  describe "GET /user_status/:id" do
    context "with valid credentials" do

      context "with a valid positive ID" do
        before do
          allow(DummyJsonApiClient).to receive(:get_user).and_return({
            'firstName' => 'John', 'lastName' => 'Doe', 'age' => 30
          })
          allow(DummyJsonApiClient).to receive(:get_user_todos).and_return({
            'todos' => [{ 'completed' => false, 'todo' => 'Task 1' }]
          })
        end

        it "returns http success" do
          get "/user_status/1", headers: headers
          expect(response).to have_http_status(:success)
        end
      end

      context "with an invalid ID format (e.g., '1s' or '-5')" do
        it "returns 404 Not Found for alphanumeric strings" do
          get "/user_status/1s", headers: headers

          expect(response).to have_http_status(:not_found)
          json = JSON.parse(response.body)
          expect(json["error"]).to eq("User ID must be a positive number")
        end

        it "returns 404 Not Found for negative numbers" do
          get "/user_status/-5", headers: headers

          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)["error"]).to include("positive number")
        end

        it "returns 404 Not Found for zero" do
          get "/user_status/0", headers: headers
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "without credentials" do
      it "returns unauthorized regardless of ID validity" do
        get "/user_status/1"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
