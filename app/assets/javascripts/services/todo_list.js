todoApp.factory('todo_listFactory', ['$http', function($http) {
  return {
    todo_listId: null,
    todo_taskId: null,

    getTodoLists: function() {
      return $http.get('/api/v1/todo_lists');
    },

    setTodoListId: function(id) {
      this.todo_listId = id;
    },

    getTodoListTodoTasks: function(id) {
      var thisId = id || this.todo_listId;
      return $http.get('/api/v1/todo_lists/' + thisId + '/todo_tasks');
    },

    submitTodoList: function(todo_listData) {
      console.log(todo_listData);
      return $http({
        method: 'POST',
        url: '/api/v1/todo_lists',
        params: todo_listData
      });
    },

    updateTodoList: function(todo_listData) {
      console.log(todo_listData);
      return $http({
        method: 'PUT',
        url: '/api/v1/todo_lists/' + todo_listData.id,
        params: { id: todo_listData.id, title: todo_listData.title,
          priority: todo_listData.priority }
      });
    },

    deleteTodoList: function(id) {
      console.log(id);
      return $http.delete('/api/v1/todo_lists/' + id);
    },

    setTodoTaskId: function(id) {
      this.todo_taskId = id;
    },

    getTodoTaskTodoComments: function(id) {
      var todo_taskId = id || this.todo_taskId;
      return $http.get('/api/v1/todo_tasks/' + todo_taskId + '/todo_comments');
    },

    submitTodoTask: function(todo_taskData) {
      console.log(todo_taskData);
      var todo_listId = this.todo_listId;
      return $http({
        method: 'POST',
        url: '/api/v1/todo_lists/' + todo_listId + '/todo_tasks',
        params: todo_taskData
      });
    },

    updateTodoTask: function(todo_taskData) {
      console.log(todo_taskData);
      return $http({
        method: 'PUT',
        url: '/api/v1/todo_tasks/' + todo_taskData.id,
        params: todo_taskData
      });
    },

    deleteTodoTask: function(todo_taskData) {
      return $http.delete('/api/v1/todo_tasks/' + todo_taskData.id);
    },

    submitTodoComment: function(todo_commentData) {
      console.log(todo_commentData);
      var todo_taskId = this.todo_taskId;
      return $http({
        method: 'POST',
        url: '/api/v1/todo_tasks/' + todo_taskId + '/todo_comments',
        params: todo_commentData
      });
    },

    deleteTodoComment: function(todo_commentData) {
      return $http.delete('/api/v1/todo_comments/' + todo_commentData.id);
    }
  };
}]);