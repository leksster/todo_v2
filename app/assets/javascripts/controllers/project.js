'use strict';

angular.module('todo')
  .controller('ProjectController', ['$scope', 'projectFactory', 'modalService', function($scope, projectFactory, modalService) {

    $scope.message = "Loading...";
    $scope.showData = false;

    $scope.projects = projectFactory.query(
      function(response) {
        $scope.projects = response;
        $scope.showData = true;
      },
      function(response) {
        $scope.message = "Error: "+response.status+ " "+response.statusText;
      });

    $scope.removeProject = function(project) {
      var index = $scope.projects.indexOf(project);
      projectFactory.remove({id: project.id});
      $scope.projects.splice(index, 1);
    };

    $scope.updateProject = function(project) {
      projectFactory.update({id: project.id, name: project.name}, function(resource) {
      });
    };

    $scope.newProject = function() {
      var modalOptions = {
        closeButtonText: 'Cancel',
        actionButtonText: 'Create',
        headerText: 'Please enter the name of your new project.',
      }

      var modalDefaults = {
        backdrop: true,
        keyboard: true,
        modalFade: true,
        templateUrl: 'assets/templates/new-project.html',
      }

      modalService.showModal(modalDefaults, modalOptions).then(function(result){
        projectFactory.save({ name: result }, function(result) {
          $scope.projects.push(result);
        });
      });

    }
  }])