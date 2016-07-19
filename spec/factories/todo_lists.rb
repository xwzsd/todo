FactoryGirl.define do
  factory :todo_list do
    title { Faker::Lorem.sentence }
    priority 1
    user
  end

  factory :todo_list_invalid, class: TodoList do
  	title ''
  	user
  end
  
end
