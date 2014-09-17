angular.module("scsBlogApp").controller "PostCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->
    TEST_CATEGORIES = ["programming", "life", "css", "tools"]

    TEST_TAGS = ["rails", "angularjs", "gem", "works", "rails_controller", "mysql", "pow", "debug"]

    TEST_POST =
      title: "測量mysql query的效能，測試文章如果標題太長的話會不會爆掉!!"
      categories: ["programming", "life", "css", "tools"]
      tags: ["rails", "angularjs", "gem", "works", "rails_controller", "mysql"]
      datetime: "2014-08-05 12:45:32"
      link: "mysql-profiling-query"

    initVars = ->
      $scope.post = TEST_POST

    loadTags = ->
      $scope.tags = TEST_TAGS

    loadCategories = ->
      $scope.categories = TEST_CATEGORIES

    init = ->
      initVars()
      $scope.$parent.updateHeaderTitle($scope.post.title)
      loadTags()
      loadCategories()

    init()
]

