class DummyJsonApiService
  API_URL = ENV["DUMMY_API"]
  def self.get_user(user_id)
    response = HTTParty.get("#{API_URL}/users/#{user_id}")
    if response.success?
      response.parsed_response
    else
      Rails.logger.error("Failed to fetch user data: #{response.code} - #{response.message}")
      nil
    end
  end

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