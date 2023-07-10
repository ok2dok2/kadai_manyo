FactoryBot.define do
  factory :task do
    name { 'テスト1' }
    detail { 'テスト1' }
    date { "2023-07-01" }
    status { 2 }
    priority { 2 }
  end
  
  factory :task2, class: Task do
    name { 'テスト2' }
    detail { 'テスト2' }
    date { "2023-07-04" }
    status { 2 }
    priority { 1 }
  end
end
