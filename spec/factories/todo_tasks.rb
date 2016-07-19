FactoryGirl.define do
  factory :todo_task do
  	content { Faker::Lorem.sentence }
  	completed_at false
  	priority 1
  	due_date { Time.now }
  	todo_list
  end

  factory :todo_task_invalid, class: TodoTask do
  	content ''
  end
  
end
