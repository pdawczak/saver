FactoryGirl.define do
  factory :page do
    url         { Faker::Internet.url } 
    title       { Faker::Name.title }
    description { Faker::Lorem.paragraphs }

    factory :page_with_user do
      user
    end
  end
end
