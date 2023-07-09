FactoryBot.define do
  factory :user do
    username { "test1" }
    email { "test1@gmail.com" }
    password { "pass" }
    password_confirmation { "pass" }
    admin { 0 }
  end

  factory :user2, class: User do
    username { "admin1" }
    email { "admin1@gmail.com" }
    password { "pass" }
    password_confirmation { "pass" }
    admin { 1 }
  end
end
