todoApp.controller('TodoCommentController', ['$scope', '$http', 'todo_listFactory', 'toastr', 'Upload',
  function($scope, $http, todo_listFactory, toastr, Upload) {
    $scope.submitTodoComment = function(todo_task) {
      todo_listFactory.setTodoTaskId(todo_task.id);
      todo_listFactory.submitTodoComment($scope.todo_commentData).success(function(data) {
        console.log(data);
        if($scope.files) {
          for (var i = 0; i < $scope.files.length; i++) {
            var file = $scope.files[i];
            Upload.upload({
              url: '/api/v1/todo_comments/' + data.id + '/todo_attachments',
              method: 'POST',
              file: file
            }).success(function(data) {
              $scope.files = [];
              todo_listFactory.getTodoTaskTodoComments().success(function(data) {
                $scope.todo_task.todo_comments = data;
              });
            });
          }
        };
        $scope.todo_commentData = {};
        todo_listFactory.getTodoTaskTodoComments().success(function(data) {
          toastr.success('Comment successfully created.');
          $scope.todo_task.todo_comments = data;
        });
      })
      .catch(function(response) {
        toastr.error('Comment can\'t be blank.');
      });
    };

    $scope.deleteTodoComment = function(todo_taskId, todo_commentData) {
      var confirmation = confirm('Are you sure?');
      if (confirmation) {
        todo_listFactory.deleteTodoComment(todo_commentData).success(function() {
          todo_listFactory.getTodoTaskTodoComments(todo_taskId).success(function(data) {
            $scope.todo_task.todo_comments = data;
          });
        });
      };
    };

    $scope.deleteAttach = function(index) {
      if (index > -1) {
        $scope.files.splice(index, 1);
      }
    };
}]);