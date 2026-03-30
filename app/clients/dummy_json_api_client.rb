# This client is responsible for interacting with the Dummy JSON API.
class DummyJsonApiClient
  API_URL = ENV["DUMMY_API"]

  # Fetches user data from the Dummy JSON API
  # @param user_id [Integer] The ID of the user to fetch
  def self.get_user(user_id)
    response = HTTParty.get("#{API_URL}/users/#{user_id}")
    if response.success?
      response.parsed_response
    else
      Rails.logger.error("Failed to fetch user data: #{response.code} - #{response.message}")
      nil
    end
  end

  # Fetches the todos for a specific user from the Dummy JSON API
  # @param user_id [Integer] The ID of the user whose todos to fetch
  def self.get_user_todos(user_id)
    response = HTTParty.get("#{API_URL}/users/#{user_id}/todos")
    if response.success?
      response.parsed_response
    else
      Rails.logger.error("Failed to fetch user todos: #{response.code} - #{response.message}")
      nil
    end
  end
end
