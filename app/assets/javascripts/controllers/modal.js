angular.module('todo').controller('NewProjectModalCtrl', function ($scope, $uibModal, $log) {

    $scope.animationsEnabled = true;

    $scope.open = function (size) {
      var modalInstance = $uibModal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'assets/templates/new-project.html',
        controller: 'ProjectInstanceModalCtrl',
        size: size,
        scope: $scope,
        resolve: {
          projectName: function() {
            return $scope.projectName;
          }
        }
      });

    // modalInstance.result.then(function (selectedItem) {
    //   $scope.selected = selectedItem;
    // }, function () {
    //   $log.info('Modal dismissed at: ' + new Date());
    // });
    };

  })

  .controller('AddDateModalCtrl', function($scope, $uibModal, $log) {
    $scope.animationsEnabled = true;

    $scope.open = function (size) {
      var modalInstance = $uibModal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'assets/templates/add-deadline.html',
        controller: 'AddDateModalInstanceCtrl',
        size: size,
        scope: $scope,
        resolve: {
          projectName: function() {
            return $scope.projectName;
          }
        }
      });
    };

    $scope.toggleAnimation = function () {
      $scope.animationsEnabled = !$scope.animationsEnabled;
    };
  })

  .controller('AddDateModalInstanceCtrl', function ($scope, $uibModalInstance, taskFactory) {
    $scope.ok = function (uDate) {
      $scope.deadline.date = uDate;
      $uibModalInstance.close();
    };

    $scope.cancel = function () {
      $uibModalInstance.dismiss('cancel');
    };
  })

  .controller('ProjectInstanceModalCtrl', function ($scope, $uibModalInstance, projectFactory) {
    $scope.ok = function () {
      projectFactory.save({ name:$scope.newProjectName }, function(resource) {
        $scope.projects.push(resource);
      });
      $uibModalInstance.close();
    };

    $scope.cancel = function () {
      $uibModalInstance.dismiss('cancel');
    };
  });