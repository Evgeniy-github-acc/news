FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    publish_date { "2023-01-26 17:00:44" }
  

    trait :with_image do
      after(:build) do |post|
        post.image.attach(io: File.open(Rails.root.join('spec', 'support', 'logo.jpg')), 
        filename: 'logo.jpg')
      end
    end
  end
end
