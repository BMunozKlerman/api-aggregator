class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  # Authenticate incoming requests using an API key (TODO: Move the api key to secrets or credentials)
  def authenticate_request
    api_key = request.headers["X-Api-Key"]

    render json: { error: "Unauthorized" }, status: :unauthorized unless api_key && api_key == ENV["API_KEY"]
  end
end
