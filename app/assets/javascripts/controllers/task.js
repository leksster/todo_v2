'use strict';

angular.module('todo')
  .controller('TaskController', ['$scope', 'taskFactory', function($scope, taskFactory) {
    $scope.removeTask = function(task) {
      var index = $scope.project.tasks.indexOf(task);
      taskFactory.remove({project_id: $scope.project.id, id: task.id});
      $scope.project.tasks.splice(index, 1);
    };

    $scope.createTask = function(project) {
      taskFactory.save( {text:$scope.newTaskText, project_id:project.id}, function(resource) {
        $scope.project.tasks.push(resource);
      });
      $scope.newTaskText = '';
    };

    $scope.updateTask = function(project, task) {
      taskFactory.update( {project_id: project.id, id: task.id, text: task.text}, function(resource) {

      });
    }
  }])