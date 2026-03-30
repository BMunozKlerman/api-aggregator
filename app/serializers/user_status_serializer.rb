class UserStatusSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :experience, :pending_task_count, :next_urgent_task
end
