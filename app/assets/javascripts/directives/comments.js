angular.module('todo')
  .directive('todoTaskComments', function() {
    return {
      restrict: 'E',
      templateUrl: 'assets/templates/todo-task-comments.html'
    };
  });