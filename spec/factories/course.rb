# frozen_string_literal: true

FactoryGirl.define do
  factory :course do
    user
    title       { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    repo_id     { Faker::Number.unique.number(8) }
    repo_name   { Faker::Internet.user_name(nil, %w[_ -]) }
    repo_url    { "https://github.com/#{user.login}/#{repo_name}" }
  end
end
