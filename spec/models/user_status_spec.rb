require 'rails_helper'

RSpec.describe UserStatus, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:experience) }
    it { should validate_presence_of(:pending_task_count) }
  end
end
