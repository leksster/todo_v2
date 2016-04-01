angular.module('todo')
  .directive('todoProjectTasks', function() {
    return {
      restrict: 'E',
      templateUrl: 'assets/templates/todo-project-tasks.html'
    };
  });