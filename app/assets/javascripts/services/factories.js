'use strict';

angular.module('todo')
  .factory('projectFactory', ['$resource', function($resource){

    return $resource('api/projects/:id', {id: '@id'}, 
      {
        update: {method: 'PUT'}
      });
  }])

  .factory('taskFactory', ['$resource', function($resource) {

    return $resource('api/projects/:project_id/tasks/:id', 
      {project_id: '@project_id', id: '@id'},
      {
        update: {method: 'PUT'}
      });
  }])

  .factory('commentFactory', ['$resource', function($resource) {
    return $resource('api/tasks/:task_id/comments/:id', 
      {task_id: '@task_id', id: '@id'},
      {
        update: {method: 'PUT'}
      });
  }]);