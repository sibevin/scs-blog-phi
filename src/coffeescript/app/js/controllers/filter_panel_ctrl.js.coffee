angular.module("scsBlogApp").controller "FilterPanelCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->
    TEST_CATEGORIES = ["programming", "life", "css", "tools"]

    TEST_TAGS = ["rails", "angularjs", "gem", "works", "rails_controller", "mysql", "pow", "debug"]

    # === filter callbacks ===

    $scope.onCfAllChange = ->
      $scope.fp_data.ca = []
      $scope.ca_filter_all = true
      $scope.ca_filter[ca] = false for ca in $scope.categories

    $scope.onCfChange = ->
      $scope.fp_data.ca = _.keys(_.omit $scope.ca_filter, (value) ->
        return value == false
      )
      if $scope.fp_data.ca.length > 0
        $scope.ca_filter_all = false
      else
        $scope.onCfAllChange()

    $scope.onTfAllChange = ->
      $scope.fp_data.tag = []
      $scope.tag_filter_all = true
      $scope.tag_filter[tag] = false for tag in $scope.tags

    $scope.onTfChange = ->
      $scope.fp_data.tag = _.keys(_.omit $scope.tag_filter, (value) ->
        return value == false
      )
      if $scope.fp_data.tag.length > 0
        $scope.tag_filter_all = false
      else
        $scope.onTfAllChange()

    initVars = ->
      $scope.ca_filter = {}
      $scope.tag_filter = {}
      $scope.fp_data.ca = []
      $scope.fp_data.tag = []

    loadTags = ->
      $scope.tags = TEST_TAGS

    loadCategories = ->
      $scope.categories = TEST_CATEGORIES

    init = ->
      initVars()
      loadTags()
      loadCategories()
      $scope.onCfAllChange()
      $scope.onTfAllChange()

    init()
]

