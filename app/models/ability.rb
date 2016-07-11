class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Todo_list, user: user
      can :manage, Todo_task, todo_list: { user_id: user.id }
      can :manage, Todo_comment, todo_task: { todo_list: { user_id: user.id } }
      can :manage, Todo_attachment, todo_comment: { todo_task: { todo_list: { user_id: user.id } } }
    end
  end
end
