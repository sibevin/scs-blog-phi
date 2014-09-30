angular.module("scsBlogApp").controller "TagListCtrl", [
  '$scope', '$filter', '$routeParams', '$anchorScroll', '$location'
  ($scope,   $filter,   $routeParams,   $anchorScroll,   $location) ->

    $scope.clearQuery = ->
      $scope.query_keyword = ""

    $scope.getFilteredTags = ->
      filtered_tags = $filter("orderBy")($scope.tags)
      if $scope.query_keyword != ""
        filtered_tags = $filter("filter")(filtered_tags, $scope.query_keyword)
      filtered_tags

    init = ->
      $scope.updateHeaderTitle("文章標籤")
      $scope.enableFilterPanel(false)
      $scope.tags = _.keys(APP_DATA.tags)
      $scope.query_keyword = ""

    init()
]
