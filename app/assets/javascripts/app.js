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

  .config(['$stateProvider', '$urlRouterProvider', '$authProvider', function($stateProvider, $urlRouterProvider, $authProvider) {
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
          auth: function($auth, $state) {
            return $auth.validateUser()
              .catch(function(response) {
                $state.go('login');
              });
          }
        }
      })
      
    $authProvider.configure({
      apiUrl: '',
      authProviderPaths: {
        facebook: 'auth/facebook'
      },
      omniauthWindowType: 'newWindow'
    })
  }])

  .config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.latencyThreshold = 0;
  }])

  .run(['$rootScope', '$state', '$stateParams', function($rootScope, $state, $stateParams) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
  }])

  .run(['editableOptions', 'editableThemes', function(editableOptions, editableThemes) {
    editableThemes.bs3.inputClass = 'input-sm';
    editableThemes.bs3.buttonsClass = 'btn-sm';
    editableOptions.theme = 'bs3';
  }]);