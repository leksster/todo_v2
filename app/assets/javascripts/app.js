'use strict';

angular
  .module('todo', [
    "ngResource",
    "xeditable", 
    "ui.bootstrap", 
    "angular-loading-bar", 
    "as.sortable", 
    "ngFileUpload",
    "ng-token-auth",
    "ui.router",
    "ui-notification"])

  .config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");

    $stateProvider
      .state('login', {
        url: "/login",
        templateUrl: 'assets/templates/sessions/new.html',
        controller: 'UserSessionsCtrl'
      })

      .state('register', {
        url: '/register',
        templateUrl: 'assets/templates/registrations/new.html',
        controller: 'UserRegistrationsCtrl'
      })

      .state('projects', {
        url: '/',
        templateUrl: 'assets/templates/index.html.haml',
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      })
    // $routeProvider
    //   .when('/', {
    //     templateUrl: 'assets/templates/sessions/new.html',
    //     controller: 'UserSessionsCtrl',
    //   })
    //   .when('/projects', {
    //     templateUrl: 'assets/templates/index.html.haml',
    //     resolve: {
    //       auth: function($auth) {
    //         return $auth.validateUser();
    //       }
    //     }
    //   })
    //   .when('/register', {
    //     templateUrl: 'assets/templates/registraions/new.html',
    //     controller: 'UserSessionsCtrl'
    //   })
    //   .otherwise({
    //     redirectTo: '/'
    //   });
  })

  .config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.latencyThreshold = 0;
  }])

  .run(function($rootScope, $state, $stateParams) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
  })

  .run(function(editableOptions, editableThemes) {
    editableThemes.bs3.inputClass = 'input-sm';
    editableThemes.bs3.buttonsClass = 'btn-sm';
    editableOptions.theme = 'bs3';
  });