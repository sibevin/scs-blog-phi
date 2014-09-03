(function() {
  var blog_app;

  blog_app = angular.module('scsBlogApp', ['ngRoute', 'hljs']);

  blog_app.config([
    "$routeProvider", function($routeProvider) {
      var path, route, routes;
      return routes = (function() {
        var _results;
        _results = [];
        for (path in ROUTES) {
          route = ROUTES[path];
          if (route.ctrl) {
            _results.push($routeProvider.when(path, {
              controller: route.ctrl,
              templateUrl: "./" + route.template
            }));
          } else {
            _results.push($routeProvider.when(path, {
              templateUrl: "./" + route.template
            }));
          }
        }
        return _results;
      })();
    }
  ]);

  angular.element(document).ready(function() {
    return angular.bootstrap(document, ['scsBlogApp']);
  });

}).call(this);
