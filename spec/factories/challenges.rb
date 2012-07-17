FactoryGirl.define do
  factory :challenge do
    sequence(:name_of_challenger) { |n| "Challenger ##{n}" }
    sequence(:title_of_challenge) { |n| "Challenge ##{n}" }
    amount 30
    project_id 1
    display_media "http://www.flushdoggy.com/wordpress/wp-content/uploads/2012/05/male-dog.jpg"
  end
end
