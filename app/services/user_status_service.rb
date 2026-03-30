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


    if user_data.is_a?(Hash) && user_data[:error].present?
      Rails.logger.error("Error fetching user data for user_id #{@user_id}: #{user_data[:error]}")
      return user_data
    end

    # This could be improbed by tring to find the user status by a unique param and updating it instead of creating a new one each time
    UserStatus.create!(
      full_name: user_data[:full_name],
      experience: user_data[:experience],
      pending_task_count: user_data[:pending_task_count],
      next_urgent_task: user_data[:next_urgent_task]
    )
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Error saving user status: #{e.message}, user_data: #{user_data}")
    { error: "Error saving user status: #{e.message}" }
  rescue StandardError => e
    Rails.logger.error("Error in UserStatusService: #{e.message}")
    { error: "Error in UserStatusService: #{e.message}" }
  end
end
