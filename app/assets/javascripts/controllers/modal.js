angular.module('todo').controller('ModalCtrl', function ($scope, $uibModal, $log) {

    $scope.animationsEnabled = true;

    $scope.open = function (size) {
      var modalInstance = $uibModal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'assets/templates/new-project.html',
        controller: 'ModalInstanceCtrl',
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

    $scope.toggleAnimation = function () {
      $scope.animationsEnabled = !$scope.animationsEnabled;
    };

  })

  .controller('ModalInstanceCtrl', function ($scope, $uibModalInstance, projectFactory) {
    $scope.ok = function () {
      projectFactory.save({ name:$scope.newProjectName }, function(resource) {
        $scope.projects.push(resource);
        console.log(resource);
      });
      $uibModalInstance.close();
    };

    $scope.cancel = function () {
      $uibModalInstance.dismiss('cancel');
    };
  });