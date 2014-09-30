angular.module("scsBlogApp").controller "HomeCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->

    # === post list usage ===

    initVars = ->

    loadPosts = ->
      $scope.posts = APP_DATA.posts

    loadTags = ->
      $scope.tags = APP_DATA.tags

    loadCategories = ->
      $scope.categories = APP_DATA.categories

    init = ->
      $scope.$parent.updateHeaderTitle(APP["header_title"])
      initVars()
      loadPosts()
      loadTags()
      loadCategories()

    init()
]

