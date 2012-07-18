# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge_evidence do
    challenge_id 1
  end

  factory :image_evidence, parent: :challenge_evidence do
    image "http://www.amazon-s3.some-image.jpg"
  end

  factory :external_evidence, parent: :challenge_evidence do
    external_url "http://www.makems.com/graphic/puppies-2.jpg"
  end
end
