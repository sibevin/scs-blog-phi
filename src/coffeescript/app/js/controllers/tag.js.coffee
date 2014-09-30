angular.module("scsBlogApp").controller "TagCtrl", [
  '$scope', '$filter', '$routeParams', '$anchorScroll', '$location'
  ($scope,   $filter,   $routeParams,   $anchorScroll,   $location) ->

    $scope.scrollTo = (id) ->
      old = $location.hash()
      $location.hash(id)
      $anchorScroll()
      $location.hash(old)

    $scope.getTagList = (query_tag) ->
      tags = [query_tag]
      for tag in _.keys(APP_DATA.tags)
        if tag.indexOf(query_tag) > -1
          tags.push(tag)
      _.uniq(tags)

    $scope.getTagPosts = (all_posts, query_tag) ->
      filtered_posts = $filter("orderBy")(all_posts, "datetime", true)
      filtered_posts = $filter("filter") filtered_posts, (post) ->
        is_in_list = false
        for tag in post.tag
          if tag == query_tag
            is_in_list = true
            break
        is_in_list
      filtered_posts

    init = ->
      $scope.posts = APP_DATA.posts
      $scope.enableFilterPanel(false)
      if $routeParams.tag && $routeParams.tag in _.keys(APP_DATA.tags)
        $scope.target_tag = $routeParams.tag
        $scope.updateHeaderTitle("文章標籤 – " + $scope.showTag($scope.target_tag))
      else
        $location.path("#/tag")

    init()
]
