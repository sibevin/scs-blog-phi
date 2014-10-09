angular.module("scsBlogApp").controller "HomeCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->

    # === post list usage ===

    RECENT_TIME_PERIOD = 2 # month

    $scope.getRecentPosts = (posts) ->
      filtered_posts = $scope.getFilteredPosts(posts)
      filtered_posts = $filter("filter") filtered_posts, (post) ->
        d = new Date()
        d.setMonth(d.getMonth() - RECENT_TIME_PERIOD)
        post_d = new Date(post.datetime)
        (post_d > d)
      filtered_posts

    loadPosts = ->
      $scope.posts = APP_DATA.posts

    init = ->
      $scope.$parent.updateHeaderTitle(APP["header_title"])
      loadPosts()

    init()
]

