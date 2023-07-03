FactoryBot.define do
  factory :task do
    name { 'テスト1' }
    detail { 'テスト1' }
    date { "2023-07-01" }
  end
  
  factory :task2, class: Task do
    name { 'テスト2' }
    content { 'テスト2' }
    status {'未着手'}
  end
end
