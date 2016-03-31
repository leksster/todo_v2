
angular.module('todo')
  .controller('UploadCtrl', ['$scope', 'Upload', '$timeout', 'commentFactory', function ($scope, Upload, $timeout, commentFactory) {

    $scope.uploadPic = function(file, task, project) {
      if (file) {
        file.upload = Upload.upload({
          url: 'api/comments',
          data: {
            comment: {
              text: $scope.newCommentText,
              task_id: task.id,
              attaches_attributes: [{file: file}]
            }        
          },
        });

        file.upload.then(function (response) {
          $timeout(function () {
            file.result = response.data;
            $scope.task.comments.push(response.data);
            $scope.file = null;
            $scope.newCommentText = '';
          });
        }, function (response) {
          if (response.status > 0)
            $scope.errorMsg = response.status + ': ' + 'Error';
        }, function (evt) {
          // Math.min is to fix IE which reports 200% sometimes
          file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
        });
      } else {
        commentFactory.save({ project_id: project.id, task_id: task.id, text: $scope.newCommentText }, function(resource) {
          $scope.task.comments.push(resource);
          $scope.newCommentText = '';
        });
      }
    }

  }]);