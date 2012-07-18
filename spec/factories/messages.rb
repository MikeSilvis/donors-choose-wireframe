FactoryGirl.define do
  factory :message do
    sequence(:name) { |n| "My Name #{n}" }
    sequence(:body) { |n| "Message Number #{n}" }
    project_id 1
  end

  factory :video_message, parent: :message do
    body "http://www.youtube.com/watch?v=LiyQ8bvLzIE&feature=g-all-u"
  end

  factory :image_message, parent: :message do
    body "http://images4.fanpop.com/image/photos/15800000/Cute-Puppy-puppies-15813366-1600-1200.jpg"
  end

  factory :link_message, parent: :message do
    body "http://google.com"
  end
end

