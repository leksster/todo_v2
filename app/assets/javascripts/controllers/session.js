angular.module('todo')
  .controller('UserSessionsCtrl', ['$scope', '$auth', '$state', 'Notification', function($scope, $auth, $state, Notification) {

    $scope.handleBtnClick = function (service) {
      $auth.authenticate(service)
        .then(function(resp) {
        })
        .catch(function(resp) {
          console.log(resp);
          Notification.error({message: resp.errors.join(), positionY: 'bottom'});
        });
    }


    $scope.$on('auth:login-success', function(ev, response) {
      $state.go('projects');
      Notification.success({message: 'Hello, '+response.email.split('@')[0]+'!', positionY: 'bottom'});
    })

    $scope.$on('auth:login-error', function(ev, reason) {
      Notification.error({message: reason.errors[0], positionY: 'bottom'});
    })


    $scope.$on('auth:logout-success', function(ev) {
      Notification({message: 'Bye.', positionY: 'bottom'});
      $state.go('login');
    })
    
  }]);