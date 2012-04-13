# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :server do
    api_url "http://susestudio.com/api/v2/user"
    username "testuser"
    password "testpass"
  end
end
