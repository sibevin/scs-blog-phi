APP = {
  "brand": "魔法師的手帳",
  "author": "Sibevin Wang",
  "footer_trademark": "2014 魔法師的手帳",
  "header_title": "寫程式就像施展魔法一樣"
}
;ROUTES = {
  "/": {
    "template": "layout/home.html",
    "ctrl": "HomeCtrl"
  },
  "/tag": {
    "template": "layout/tag.html",
    "ctrl": "TagCtrl"
  },
  "/post": {
    "template": "layout/post.html",
    "ctrl": "TagCtrl"
  }
}
;CSS_FILES = ["../css/app.css", "../css/app.min.css", "../css/blog.css", "../css/min.css"];ROUTES = {
  "/": {
    "template": "layout/home.html",
    "ctrl": "HomeCtrl"
  },
  "/tag": {
    "template": "layout/tag.html",
    "ctrl": "TagCtrl"
  },
  "/post": {
    "template": "layout/post.html",
    "ctrl": "TagCtrl"
  }
}
;(function() {
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
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  angular.module("scsBlogApp").controller("HomeCtrl", [
    '$scope', '$filter', function($scope, $filter) {
      var TEST_CATEGORIES, TEST_POSTS, TEST_TAGS, getDateArr, init, initVars, loadCategories, loadPosts, loadTags;
      TEST_CATEGORIES = ["programming", "life", "css", "tools"];
      TEST_TAGS = ["rails", "angularjs", "gem", "works", "rails_controller", "mysql", "pow", "debug"];
      TEST_POSTS = [
        {
          title: "如何顯示utf8的欄位",
          categories: ["programming"],
          tags: ["mysql"],
          datetime: "2014-03-04 13:10:15",
          link: "mysql-utf8-display"
        }, {
          title: "mysql指令一覽",
          categories: ["programming"],
          tags: ["mysql", "cheat_sheet"],
          datetime: "2014-03-04 16:23:26",
          link: "mysql-cheat-sheet"
        }, {
          title: "測量mysql query的效能",
          categories: ["tools"],
          tags: ["mysql"],
          datetime: "2014-08-05 12:45:32",
          link: "mysql-profiling-query"
        }, {
          title: "Random Token",
          categories: ["programming"],
          tags: ["gem", "works"],
          datetime: "2014-05-14 10:01:17",
          link: "gem-random-token"
        }, {
          title: "oh-my-zsh一些實用小技巧",
          categories: ["tools"],
          tags: ["zsh"],
          datetime: "2014-05-07 22:12:34",
          link: "oh-my-zsh-tips"
        }, {
          title: "在pow中設定debugger",
          categories: ["tools"],
          tags: ["pow", "debug", "rails"],
          datetime: "2014-05-07 22:12:34",
          link: "setup-debugger-for-pow"
        }, {
          title: "如何做到before_render",
          categories: ["programming"],
          tags: ["rails", "rails_controller"],
          datetime: "2014-02-23 13:00:36",
          link: "rails-how-to-before-render"
        }, {
          title: "在rails中設置grape",
          categories: ["programming"],
          tags: ["rails", "grape"],
          datetime: "2014-02-28 10:42:57",
          link: "rails-grape-setup"
        }
      ];
      $scope.onCfAllChange = function() {
        var ca, _i, _len, _ref, _results;
        $scope.filtered_cas = [];
        $scope.ca_filter_all = true;
        _ref = $scope.categories;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          ca = _ref[_i];
          _results.push($scope.ca_filter[ca] = false);
        }
        return _results;
      };
      $scope.onCfChange = function() {
        $scope.filtered_cas = _.keys(_.omit($scope.ca_filter, function(value) {
          return value === false;
        }));
        if ($scope.filtered_cas.length > 0) {
          return $scope.ca_filter_all = false;
        } else {
          return $scope.onCfAllChange();
        }
      };
      $scope.onTfAllChange = function() {
        var tag, _i, _len, _ref, _results;
        $scope.filtered_tags = [];
        $scope.tag_filter_all = true;
        _ref = $scope.tags;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          tag = _ref[_i];
          _results.push($scope.tag_filter[tag] = false);
        }
        return _results;
      };
      $scope.onTfChange = function() {
        $scope.filtered_tags = _.keys(_.omit($scope.tag_filter, function(value) {
          return value === false;
        }));
        if ($scope.filtered_tags.length > 0) {
          return $scope.tag_filter_all = false;
        } else {
          return $scope.onTfAllChange();
        }
      };
      $scope.getFilteredPosts = function() {
        var filtered_posts;
        filtered_posts = $filter("orderBy")($scope.posts, "datetime", true);
        if ($scope.filtered_tags.length > 0) {
          filtered_posts = $filter("filter")(filtered_posts, function(post) {
            var is_in_list, tag, _i, _len, _ref;
            is_in_list = false;
            _ref = post.tags;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              tag = _ref[_i];
              if (__indexOf.call($scope.filtered_tags, tag) >= 0) {
                is_in_list = true;
                break;
              }
            }
            return is_in_list;
          });
        }
        if ($scope.filtered_cas.length > 0) {
          filtered_posts = $filter("filter")(filtered_posts, function(post) {
            var ca, is_in_list, _i, _len, _ref;
            is_in_list = false;
            _ref = post.categories;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              ca = _ref[_i];
              if (__indexOf.call($scope.filtered_cas, ca) >= 0) {
                is_in_list = true;
                break;
              }
            }
            return is_in_list;
          });
        }
        return filtered_posts;
      };
      getDateArr = function(post) {
        var date_arr;
        date_arr = post.datetime.match(/(\d{4})-(\d{2})-(\d{2})/);
        return _.rest(date_arr);
      };
      $scope.getDateLink = function(post, kind) {
        var date_arr, link, result;
        date_arr = getDateArr(post);
        link = "#/";
        result = (function() {
          switch (kind) {
            case "y":
              return (_.initial(date_arr, 2)).join("/");
            case "m":
              return (_.initial(date_arr, 1)).join("/");
            case "d":
              return date_arr.join("/");
          }
        })();
        return link + result;
      };
      $scope.getPostLink = function(post) {
        var date_arr;
        date_arr = getDateArr(post);
        return "#/" + date_arr.join("/") + "/" + post.link;
      };
      $scope.getDateValue = function(post, kind) {
        var date_arr, result;
        date_arr = getDateArr(post);
        result = (function() {
          switch (kind) {
            case "y":
              return date_arr[0];
            case "m":
              return date_arr[1];
            case "d":
              return date_arr[2];
          }
        })();
        return result;
      };
      initVars = function() {
        $scope.ca_filter = {};
        $scope.tag_filter = {};
        $scope.filtered_cas = [];
        return $scope.filtered_tags = [];
      };
      loadPosts = function() {
        return $scope.posts = TEST_POSTS;
      };
      loadTags = function() {
        return $scope.tags = TEST_TAGS;
      };
      loadCategories = function() {
        return $scope.categories = TEST_CATEGORIES;
      };
      init = function() {
        $scope.$parent.updateHeaderTitle(APP["header_title"]);
        initVars();
        loadPosts();
        loadTags();
        loadCategories();
        $scope.onCfAllChange();
        return $scope.onTfAllChange();
      };
      return init();
    }
  ]);

}).call(this);
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
