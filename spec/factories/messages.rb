FactoryGirl.define do
  factory :message do
    sequence(:name) { |n| "My Name #{n}" }
    sequence(:body) { |n| "Message Number #{n}" }
    sequence(:project_id) { |n| n }
  end
end
