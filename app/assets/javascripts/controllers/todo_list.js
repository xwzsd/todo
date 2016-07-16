todoApp.controller('TodoListController', ['$scope', '$http', 'todo_listFactory', 'toastr',
  function($scope, $http, todo_listFactory, toastr) {
    $scope.todo_listData = {};

    $scope.getTodoLists = function() {
      todo_listFactory.getTodoLists().success(function(data) {
        $scope.todo_lists = data;
      });
    };

    $scope.submitTodoList = function() {
      todo_listFactory.submitTodoList($scope.todo_listData).success(function() {
        $scope.todo_listData = {};
        $scope.getTodoLists();
      });
    };

    $scope.deleteTodoList = function(id) {
      var confirmation = confirm('Are you sure?');
      if(confirmation) {
        todo_listFactory.deleteTodoList(id).success(function() {
          $scope.getTodoLists();
        });
      }
    };

    $scope.TodoListEdit = function() {
      $(event.target).closest('div').toggleClass('editing');
    };

    $scope.editTodoListOnEnter = function(todo_list) {
      if(!todo_list.title) {
        toastr.error('Project name can\'t be blank.');
      };
      if(event.keyCode == 13 && todo_list.title) {
        todo_listFactory.updateTodoList(todo_list);
        $scope.todo_listEdit();
      }
    };

    $scope.toggleTodoListEdit = function() {
      $(event.target).parents().eq(1).toggleClass('editing');
    };

    $scope.sortableOptions = {
      stop: function(e, ui) {
        _.map($scope.todo_lists, function(todo_list, index) {
          todo_listFactory.updateTodoList({id: todo_list.id, priority: index})
        })
      },
      axis: 'y'
    };

    $scope.getTodoLists();
}]);