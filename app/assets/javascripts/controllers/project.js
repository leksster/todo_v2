'use strict';

angular.module('todo')
  .controller('ProjectController', ['$scope', 'projectFactory', function($scope, projectFactory) {

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
    console.log($scope.projects.tasks);

    $scope.removeProject = function(project) {
      var index = $scope.projects.indexOf(project);
      projectFactory.remove({id: project.id});
      $scope.projects.splice(index, 1);
    };

    $scope.updateProject = function(project) {
      projectFactory.update({id: project.id, name: project.name}, function(resource) {
      });
    }
  }])