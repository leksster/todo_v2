'use strict';

angular.module('todo')
  .controller('TaskController', ['$scope', 'taskFactory', 'projectFactory', 'modalService', function($scope, taskFactory, projectFactory, modalService) {

    $scope.deadline = {};

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

    $scope.addDeadline = function() {
      var modalOptions = {
        closeButtonText: 'Cancel',
        actionButtonText: 'Add',
        headerText: 'Add task deadline.'
      }

      var modalDefaults = {
        animation: true,
        templateUrl: 'assets/templates/modals/add-deadline.html'
      }

      modalService.showModal(modalDefaults, modalOptions).then(function(result){
        $scope.deadline.date = result;
      })
    }

    $scope.markTask = function(project, task, doneValue) {
      taskFactory.update( {project_id: project.id, id: task.id, done: doneValue} )
    }

    $scope.editTask = function(project, task) {

      var modalOptions = {
        closeButtonText: 'Cancel',
        actionButtonText: 'Update',
        headerText: 'Edit task',
        task: task.text
      }

      var modalDefaults = {
        animation: true,
        templateUrl: 'assets/templates/modals/edit-task.html'
      }

      modalService.showModal(modalDefaults, modalOptions).then(function(result){
        taskFactory.update( {project_id: project.id, id: task.id, text: result.text, deadline: result.deadline} )
          .$promise.then(function(result) {
            task.deadline = result.deadline;
            task.text = result.text;
          });
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