'use strict';

angular.module('todo')
  .factory('projectFactory', ['$resource', function($resource){

    return $resource('api/projects/:id', {id: '@id'}, 
      {
        update: {method: 'PUT'}
      });
  }])

  .factory('taskFactory', ['$resource', function($resource) {

    return $resource('api/tasks/:id', {project_id: '@project_id', id: '@id'},
      {
        update: {method: 'PUT'},
        save:   {method: 'POST', url: 'api/projects/:project_id/tasks' }
      });
  }])

  .factory('commentFactory', ['$resource', function($resource) {
    return $resource('api/comments/:id', {task_id: '@task_id', id: '@id'},
      {
        save:   {method: 'POST', url: 'api/tasks/:task_id/comments'},
        update: {method: 'PUT'}
      });
  }]);