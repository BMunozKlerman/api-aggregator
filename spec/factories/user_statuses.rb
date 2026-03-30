FactoryBot.define do
  factory :user_status do
    full_name { Faker::Name.name }
    experience { [ 'Rookie', 'Veteran' ].sample }
    pending_task_count { rand(1..10) }
    next_urgent_task { Faker::Lorem.sentence }
  end
end
