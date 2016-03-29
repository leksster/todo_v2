'use strict';

angular.module('todo')
  .factory('projectFactory', ['$resource', function($resource){

    return $resource('api/projects/:id', {id: '@id'}, 
      {
        update: {method: 'PUT'}
      });
    // var listProjects = {};

    // listProjects.getProjects = function() {
    //   return $resource('api/projects/:id', {id: '@id'});
    // };

    // // return listProjects;

  }])

  .factory('taskFactory', ['$resource', function($resource) {

    return $resource('api/projects/:project_id/tasks/:id', 
      {project_id: '@project_id', id: '@id'},
      {
        update: {method: 'PUT'}
      });

    // var listTasks = {};

    // listTasks.getTasks = function() {
    //   return $reseource('api/projects/:project_id/tasks/:id')
    // }

  }])

  .factory('commentFactory', ['$resource', function($resource) {
    return $resource('api/projects/:project_id/tasks/:task_id/comments/:id', 
      {project_id: '@project_id', task_id: '@task_id', id: '@id'},
      {
        update: {method: 'PUT'}
      });

  }]);