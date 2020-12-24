FactoryBot.define do
  factory :task do
    title {"test"}
    content {"test"}
    status { "todo" }
    deadline { Time.now }
    association :user
  end
end
