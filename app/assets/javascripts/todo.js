var todoApp = angular.module('todoApp', [
  'ngResource',
  'ngAnimate',
  'angular-loading-bar',
  'templates',
  'toastr',
  'ui.router',
  'ui.sortable',
  'ui.bootstrap.datetimepicker',
  'ng-token-auth',
  'ngFileUpload'
]);

todoApp.config([
  '$stateProvider',
  '$urlRouterProvider',
  '$authProvider',
  function($stateProvider, $urlRouterProvider, $authProvider) {
    $stateProvider
      .state('todo_lists',
      {
        url: '/todo_lists',
        templateUrl: 'todo_list.html',
        controller: 'TodoListController as todo_listCtrl',
        resolve: {
          auth: ['$auth', '$state', function($auth, $state) {
            return $auth.validateUser()
              .catch(function(response) {
                $state.go('signin');
              })
          }]
        }
      })
      .state('signin',
      {
        url: '/signin',
        templateUrl: '_signin.html',
        controller: 'SessionController'
      })
      .state('signup',
      {
        url: '/signup',
        templateUrl: '_signup.html',
        controller: 'RegistrationController',
      });
    $urlRouterProvider.otherwise('signin');
    $authProvider.configure({
      apiUrl: ''
    });
}]);

todoApp.config(['toastrConfig', function(toastrConfig) {
  angular.extend(toastrConfig, {
    positionClass: 'toast-top-left',
    preventOpenDuplicates: true
  });
}]);

todoApp.run(['$auth', '$state', function($auth, $state) {
  $auth.validateUser()
    .then(function(response) {
      $state.go('todo_lists');
    });
}]);