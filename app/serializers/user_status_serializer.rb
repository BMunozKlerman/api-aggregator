# This serializer is responsible for defining how the user status data is represented in the API responses.
class UserStatusSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :experience, :pending_task_count, :next_urgent_task
end
