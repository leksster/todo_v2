'use strict';

angular.module('todo')
  .controller('CommentController', ['$scope', 'commentFactory', 'Upload', '$timeout', function($scope, commentFactory, Upload, $timeout) {

    $scope.createComment = function(file, task, project) {
      if (file) {
        file.upload = Upload.upload({
          url: 'api/tasks/'+task.id+'/comments',
          data: {
            comment: {
              text: $scope.newCommentText,
              task_id: task.id,
              attaches_attributes: [{file: file}]
            }        
          }
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
            $scope.errorMsg = response.status + ': Error';
        }, function (evt) {
          // Math.min is to fix IE which reports 200% sometimes
          file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
        });
      } else {
        commentFactory.save({ task_id: task.id, text: $scope.newCommentText }, function(resource) {
          $scope.task.comments.push(resource);
          $scope.newCommentText = '';
        });
      }
    };

    $scope.removeComment = function(task, comment) {
      var index = $scope.task.comments.indexOf(comment);
      commentFactory.remove({id: comment.id});
      $scope.task.comments.splice(index, 1);
    };

    $scope.updateComment = function(comment) {
      commentFactory.update({id: comment.id, text: comment.text});
    };

    $scope.urlToName = function(url) {
      return url.split("/").pop();
    };

    $scope.validateText = function(data) {
      if (data === '') {
        return ' ';
      }
    };
  }])