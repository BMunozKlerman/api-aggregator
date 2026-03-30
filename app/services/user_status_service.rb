class UserStatusService
  def initialize(user_id)
  @user_id = user_id
  end

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
