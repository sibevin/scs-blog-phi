angular.module("scsBlogApp").controller "CaCtrl", [
  '$scope', '$filter', '$routeParams', '$location'
  ($scope,   $filter,   $routeParams,   $location) ->

    $scope.getCaPosts = (all_posts, query_ca) ->
      filtered_posts = $filter("orderBy")(all_posts, "datetime", true)
      filtered_posts = $filter("filter") filtered_posts, (post) ->
        is_in_list = false
        for ca in post.category
          if ca == query_ca
            is_in_list = true
            break
        is_in_list
      filtered_posts

    init = ->
      $scope.posts = APP_DATA.posts
      $scope.enableFilterPanel(false)
      if $routeParams.ca && $routeParams.ca in _.keys(APP_DATA.categories)
        $scope.target_ca = $routeParams.ca
        $scope.updateHeaderTitle("文章標籤 – " + $scope.showCa($scope.target_ca))
      else
        $location.path("#/category")

    init()
]
