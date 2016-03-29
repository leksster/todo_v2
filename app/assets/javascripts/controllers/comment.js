'use strict';

angular.module('todo')
  .controller('CommentController', ['$scope', 'commentFactory', '$timeout', function($scope, commentFactory, $timeout) {

    // $scope.message = "Loading...";
    // $scope.showData = false;

    $scope.createComment = function(project, task) {
      commentFactory.save({ project_id: project.id, task_id: task.id, text: $scope.newCommentText }, function(resource) {
        $scope.task.comments.push(resource);
        $scope.newCommentText = '';
      });
    };


    $scope.removeComment = function(project, task, comment) {
      var index = $scope.task.comments.indexOf(comment);
      commentFactory.remove({project_id: project.id, task_id: task.id, id: comment.id});
      $scope.task.comments.splice(index, 1);
    };

    $scope.updateComment = function(project, task, comment) {
      commentFactory.update({project_id: project.id, task_id: task.id, id: comment.id, text: comment.text});
    };

    // $scope.updateProject = function(project) {
    //   projectFactory.update({id: project.id, name: project.name}, function(resource) {
    //   });
    // };
  }])