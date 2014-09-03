angular.module("scsBlogApp").controller "RootCtrl", [
  '$scope'
  ($scope) ->
    $scope.updateHeaderTitle = (title) ->
      $scope.header_title = title
    init = ->
      $scope.brand = APP["brand"]
      $scope.author = APP["author"]
      $scope.footer_trademark = APP["footer_trademark"]
    init()
]
