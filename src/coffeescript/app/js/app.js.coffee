blog_app = angular.module('scsBlogApp', ['ngRoute', 'hljs'])

blog_app.config [
  "$routeProvider"
  ($routeProvider) ->
    for path,route of ROUTES
      if route.ctrl
        $routeProvider.
          when(path,
            controller: route.ctrl
            templateUrl: "./"+route.template
          )
      else
        $routeProvider.
          when(path,
            templateUrl: "./"+route.template
          )
]

angular.element(document).ready ->
  angular.bootstrap(document, ['scsBlogApp'])
