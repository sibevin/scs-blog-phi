angular.module("scsBlogApp").controller "CaListCtrl", [
  '$scope', '$filter', '$routeParams', '$anchorScroll', '$location'
  ($scope,   $filter,   $routeParams,   $anchorScroll,   $location) ->

    $scope.clearQuery = ->
      $scope.query_keyword = ""

    $scope.getFilteredCas = ->
      filtered_cas = $filter("orderBy")($scope.categories)
      if $scope.query_keyword != ""
        filtered_cas = $filter("filter")(filtered_cas, $scope.query_keyword)
      filtered_cas

    init = ->
      $scope.updateHeaderTitle("文章分類")
      $scope.enableFilterPanel(false)
      $scope.categories = _.keys(APP_DATA.categories)
      $scope.query_keyword = ""

    init()
]
