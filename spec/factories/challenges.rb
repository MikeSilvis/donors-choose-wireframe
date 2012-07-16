FactoryGirl.define do
  factory :challenge do
<<<<<<< HEAD
  	name_of_challenger "Darrell"
  	title_of_challenge "I will shave off my head"
  	amount 5
=======
    sequence(:name_of_challenger) { |n| "Challenger ##{n}" }
    sequence(:title_of_challenge) { |n| "Challenge ##{n}" }
    amount 30
    project_id 1
>>>>>>> 90675ae0a23f0a05d994168e445b575e0aa43d0e
  end
end
