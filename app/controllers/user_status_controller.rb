class UserStatusController < ApplicationController
  def show
    user_id = user_status_params[:id]
    user_status = UserStatusService.new(user_id).get_user

    if user_status.nil? || user_status[:error].present?
      render json: { error: user_status[:error] || "User status not found" }, status: :not_found
    else
      render json: user_status, status: :ok
    end
  end

  private
  def user_status_params
    params.permit(:id)
  end
end
