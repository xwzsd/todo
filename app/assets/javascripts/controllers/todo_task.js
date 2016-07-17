todoApp.controller('TodoTaskController', ['$scope', '$http', 'todo_listFactory', 'toastr',
  function($scope, $http, todo_listFactory, toastr) {
    $scope.submitTodoTask = function(todo_listId) {
      todo_listFactory.setTodoListId(todo_listId);
      todo_listFactory.submitTodoTask($scope.todo_taskData).success(function() {
        $scope.todo_taskData = {};
        todo_listFactory.getTodoListTodoTasks(todo_listId).success(function(data) {
          $scope.todo_list.todo_tasks = data;
        });
      })
      .catch(function(response) {
        toastr.error('Task can\'t be blank.');
      });
    };

    $scope.updateTodoTask = function(todo_taskData) {
      todo_listFactory.updateTodoTask(todo_taskData);
    };

    $scope.deleteTodoTask = function(todo_listId, todo_taskData) {
      var confirmation = confirm('Are you sure?');
      if (confirmation) {
        todo_listFactory.deleteTodoTask(todo_taskData).success(function() {
          todo_listFactory.getTodoListTodoTasks(todo_listId).success(function(data) {
            $scope.todo_list.todo_tasks = data;
          });
        });
      };
    };

    $scope.todo_taskEdit = function() {
      $(event.target).closest('div').toggleClass('editing');
    };

    $scope.editTodoTaskOnEnter = function(todo_task) {
      if(!todo_task.content) {
        toastr.error('Task content can\'t be blank.');
      };
      if(event.keyCode == 13 && todo_task.content) {
        $scope.updateTodoTask(todo_task);
        $scope.todo_taskEdit();
      };
    };

    $scope.toggleTodoTaskEdit = function() {
      $(event.target).closest('tr').find('td.todo_task-content div').
        toggleClass('editing');
    };

    $scope.toggleTodoComments = function() {
      $(event.target).closest('tr').find('td.todo_task-content div.todo_comments').
        toggleClass('todo_comments-on');
    };

    $scope.setDue = function(todo_task) {
      $scope.updateTodoTask(todo_task);
      $scope.optionsTodoTask = false;
    };

    $scope.sortableOptions = {
      stop: function(e, ui) {
        _.map($scope.todo_list.todo_tasks, function(todo_task, index) {
          todo_listFactory.updateTodoTask({todo_list_id: todo_task.todo_list_id, id: todo_task.id, priority: index}) 
        })
      },
      helper: function (e, ui) {
        ui.children().each(function() {
          $(this).width($(this).width());
        });
        return ui;
      },
      items: 'tr:not(.not-sortable)',
      axis: 'y'
    };
}]);