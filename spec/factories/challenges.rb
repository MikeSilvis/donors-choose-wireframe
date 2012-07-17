FactoryGirl.define do
  factory :challenge do
    sequence(:name_of_challenger) { |n| "Challenger ##{n}" }
    sequence(:title_of_challenge) { |n| "Challenge ##{n}" }
    amount 30
    project_id 1
  end
end
