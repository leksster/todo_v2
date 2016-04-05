angular.module('todo').controller('DatepickerDemoCtrl', function ($scope) {
  $scope.dt = null;

  $scope.inlineOptions = {
    minDate: new Date(),
    showWeeks: true
  };

  $scope.setDate = function(year, month, day) {
    $scope.dt = new Date(year, month, day);
  };

  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
  $scope.format = $scope.formats[0];
  $scope.altInputFormats = ['M!/d!/yyyy'];

});