(function() {
  angular.module("scsBlogApp").controller("TagCtrl", [
    '$scope', function($scope) {
      var init;
      init = function() {
        return $scope.$parent.updateHeaderTitle("文章標籤");
      };
      return init();
    }
  ]);

}).call(this);
