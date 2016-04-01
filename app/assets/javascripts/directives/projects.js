angular.module('todo')
  .directive('todoProjects', function() {
    return {
      restrict: 'E',
      templateUrl: 'assets/templates/todo-projects.html'
    };
  });