# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string           not null
#  title       :string           not null
#  description :text
#  identifier  :uuid
#

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
