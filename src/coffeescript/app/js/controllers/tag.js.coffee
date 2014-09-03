angular.module("scsBlogApp").controller "TagCtrl", [
  '$scope'
  ($scope) ->
    init = ->
      $scope.$parent.updateHeaderTitle("文章標籤")
    init()
]
