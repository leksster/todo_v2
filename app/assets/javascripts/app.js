'use strict';

angular.module('todo', ["ngResource", "xeditable", "ui.bootstrap", "angular-loading-bar", "as.sortable", "ngFileUpload"])
  .config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.latencyThreshold = 0;
  }])

  .run(function(editableOptions, editableThemes) {
    editableThemes.bs3.inputClass = 'input-sm';
    editableThemes.bs3.buttonsClass = 'btn-sm';
    editableOptions.theme = 'bs3';
  });