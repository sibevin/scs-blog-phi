angular.module("scsBlogApp").controller "PostCtrl", [
  '$scope', '$filter', '$routeParams', '$location'
  ($scope,   $filter,   $routeParams,   $location) ->

    EMPTY_POST =
      title: ""
      categories: []
      tags: []
      datetime: "0000-00-00 00:00:00"
      link: ""

    getHtmlLink = (post) ->
      post.file

    hasTemplate = (template) ->
      template in target_post.template

    init = ->
      $scope.enableFilterPanel(false)
      # check if link is assigned
      $scope.target_post = _.find(APP_DATA.posts, (post) ->
        post.link == $routeParams.link
      )
      if $scope.target_post
        $scope.$parent.updateHeaderTitle($scope.target_post.title)
        $scope.target_html = "posts/" + getHtmlLink($scope.target_post) + ".html"
      else
        $scope.$parent.updateHeaderTitle("找不到對應網址的文章…")
        $scope.target_post = EMPTY_POST
        $scope.target_html = "errors/404.html"

    init()
]
