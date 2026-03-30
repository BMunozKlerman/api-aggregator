# This service is responsible for fetching the user status by calling the FetchUserDataService and saving the result to the database.
class UserStatusService
  # Initializes the service with the given user ID
  # @param user_id [Integer] The ID of the user to fetch data for
  def initialize(user_id)
    @user_id = user_id
  end

  # Fetches the user status by calling the FetchUserDataService and saving the result to the database
  def get_user
    fetch_service = FetchUserDataService.new(@user_id)
    user_data = fetch_service.call

    return nil unless user_data

    # This could be improbed by tring to find the user status by a unique param and updating it instead of creating a new one each time
    UserStatus.create!(
      full_name: user_data[:full_name],
      experience: user_data[:experience],
      pending_task_count: user_data[:pending_task_count],
      next_urgent_task: user_data[:next_urgent_task]
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Error saving user status: #{e.message}, user_data: #{user_data}")
    nil
  end
end
