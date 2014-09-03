(function() {
  angular.module("scsBlogApp").controller("RootCtrl", [
    '$scope', function($scope) {
      var init;
      $scope.updateHeaderTitle = function(title) {
        return $scope.header_title = title;
      };
      init = function() {
        $scope.brand = APP["brand"];
        $scope.author = APP["author"];
        return $scope.footer_trademark = APP["footer_trademark"];
      };
      return init();
    }
  ]);

}).call(this);
