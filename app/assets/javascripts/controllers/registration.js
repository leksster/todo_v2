angular.module('todo')
  .controller('UserRegistrationsCtrl', ['$scope', '$auth', '$state', 'Notification', function($scope, $auth, $state, Notification) {

    $scope.$on('auth:registration-email-success', function(ev, message) {
      $state.go('projects');
      Notification.success({message: 'Welcome '+ message.email+'!', positionY: 'bottom' });
    });

    $scope.$on('auth:registration-email-error', function(ev, reason) {
      Notification.error({message: reason.errors.full_messages.join(), positionY: 'bottom' });
    });
    
  }]);