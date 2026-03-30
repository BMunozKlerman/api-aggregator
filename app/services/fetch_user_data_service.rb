class FetchUserDataService
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      raise ArgumentError, 'User ID is required' unless @user_id.present?
      raise ArgumentError, 'User ID must be a positive number' unless @user_id.to_i > 0

      user_data = DummyJsonApiService.get_user(@user_id)
      user_todos = DummyJsonApiService.get_user_todos(@user_id)

      return parse_user_data(user_data, user_todos) if user_data && user_todos

      nil
    rescue StandardError => e
      Rails.logger.error("Error fetching user data: #{e.message}")
      nil
    end

    def parse_user_data(user_data, user_todos)
      Rails.logger.debug("user_data: #{user_data}, user_todos: #{user_todos}")
      {
        full_name: "#{user_data['firstName']} #{user_data['lastName']}",
        experience: user_data['age'].to_i > 50 ? 'Veteran' : 'Rookie',
        pending_task_count: user_todos['todos'].count { |todo| !todo['completed'] },
        next_urgent_task: user_todos['todos'].find { |todo| !todo['completed'] }&.dig('todo')
      }
    rescue StandardError => e
      Rails.logger.error("Error parsing user data: #{e.message}, user_data: #{user_data}, user_todos: #{user_todos}")
      nil
    end
end