# app/models/user_status.rb
class UserStatus < ApplicationRecord
  validates :full_name, presence: true
  validates :experience, presence: true
  validates :pending_task_count, presence: true
end