angular.module("scsBlogApp").controller "PostCtrl", [
  '$scope', '$filter', '$routeParams', '$location', '$http'
  ($scope,   $filter,   $routeParams,   $location,   $http) ->

    EMPTY_POST =
      title: ""
      categories: []
      tags: []
      datetime: "0000-00-00 00:00:00"
      link: ""

    hasTemplate = (template) ->
      template in target_post.template

    getDraftHtmlFile = (post) ->
      "drafts/" + post.file + ".html"

    init = ->
      $scope.enableFilterPanel(false)
      # check if link is assigned
      $scope.target_post = _.find(APP_DATA.posts, (post) ->
        post.link == $routeParams.link
      )
      $scope.setPrintMode(($routeParams.display == "print"))
      if $scope.target_post
        $scope.$parent.updateHeaderTitle($scope.target_post.title)
        target_html = $scope.getPostHtmlFile($scope.target_post)
        $http({method: 'GET', url: target_html}).success( (data, status, headers, config) ->
          $scope.target_html = target_html
          $scope.is_draft = ($scope.target_post.draft == true)
        ).error (data, status, headers, config) ->
          target_html = getDraftHtmlFile($scope.target_post)
          $http({method: 'GET', url: target_html}).success( (data, status, headers, config) ->
            $scope.target_html = target_html
            $scope.is_draft = true
          ).error (data, status, headers, config) ->
            $scope.$parent.updateHeaderTitle("找不到對應網址的文章…")
            $scope.target_post = EMPTY_POST
            $scope.target_html = "errors/404.html"
      else
        $scope.$parent.updateHeaderTitle("找不到對應網址的文章…")
        $scope.target_post = EMPTY_POST
        $scope.target_html = "errors/404.html"

    init()
]
