'use strict';

angular.module('todo')
  .controller('TaskController', ['$scope', 'taskFactory', 'projectFactory', function($scope, taskFactory, projectFactory) {

    $scope.deadline = {};
    $scope.deadline.date = '';

    $scope.project.tasks.sort(function(a,b) {
      var n = a.priority - b.priority;
      if (n !== 0) {
        return n;
      }
      return b.id - a.id;
    });

    $scope.removeTask = function(task) {
      var index = $scope.project.tasks.indexOf(task);
      taskFactory.remove({project_id: $scope.project.id, id: task.id});
      $scope.project.tasks.splice(index, 1);
    };

    $scope.createTask = function(project) {
      taskFactory.save( {text:$scope.newTask, project_id:project.id, deadline: $scope.deadline.date}, function(resource) {
        $scope.project.tasks.unshift(resource);
      });
      $scope.newTask = '';
      $scope.deadline.date = '';
    };

    $scope.updateTask = function(project, task) {
      taskFactory.update( {project_id: project.id, id: task.id, text: task.text, deadline: $scope.deadline}, function(resource) {
      });
    }

    $scope.dragControlListeners = {
      accept: function (sourceItemHandleScope, destSortableScope) {
        return true;
      },
      itemMoved: function () {
        projectFactory.update( {id:$scope.project.id, tasks: $scope.project.tasks}, function(resource){
        });
      },
      orderChanged: function() {
        for (var i=0; i < $scope.project.tasks.length; i++) {
          taskFactory.update( {project_id: $scope.project.id, id:$scope.project.tasks[i].id, priority: i} );
        }
      },
      allowDuplicates: false 
    };
  }])