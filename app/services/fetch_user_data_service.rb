# This service is responsible for fetching and parsing user data from the Dummy JSON API.
class FetchUserDataService
    # Initializes the service with the given user ID
    # @param user_id [Integer] The ID of the user to fetch data for
    def initialize(user_id)
      @user_id = user_id
    end

    # Executes the service to fetch and parse user data
    def call
      raise ArgumentError, "User ID is required" unless @user_id.present?
      raise ArgumentError, "User ID must be a positive number" unless @user_id.to_i > 0

      user_data = DummyJsonApiService.get_user(@user_id)
      user_todos = DummyJsonApiService.get_user_todos(@user_id)

      return parse_user_data(user_data, user_todos) if user_data && user_todos

      nil
    rescue StandardError => e
      Rails.logger.error("Error fetching user data: #{e.message}")
      nil
    end

    private

    # Parses the user data and todos to create a structured response
    # @param user_data [Hash] The raw user data from the API
    # @param user_todos [Hash] The raw user's todos data from the API
    def parse_user_data(user_data, user_todos)
      {
        full_name: "#{user_data["firstName"]} #{user_data["lastName"]}",
        experience: user_data["age"].to_i > 50 ? "Veteran" : "Rookie",
        pending_task_count: user_todos["todos"].count { |todo| !todo["completed"] },
        next_urgent_task: user_todos["todos"].find { |todo| !todo["completed"] }&.dig("todo")
      }
    rescue StandardError => e
      Rails.logger.error("Error parsing user data: #{e.message}, user_data: #{user_data}, user_todos: #{user_todos}")
      nil
    end
end
