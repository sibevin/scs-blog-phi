angular.module("scsBlogApp").controller "HomeCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->
    TEST_CATEGORIES = ["programming", "life", "css", "tools"]

    TEST_TAGS = ["rails", "angularjs", "gem", "works", "rails_controller", "mysql", "pow", "debug"]

    TEST_TAGS = [
      name: "rails"
      count: 3
      parent: null
    ,
      name: "controller"
      count: 2
      parent: "rails"
    ,
      name: "angular"
      count: 2
      parent: "js"
    ,
      name: "js"
      count: 0
      parent: null
    ,
      name: "gem"
      count: 5
      parent: null
    ,
      name: "works"
      count: 9
      parent: null
    ,
      name: "mysql"
      count: 3
      parent: null
    ,
      name: "debug"
      count: 3
      parent: null
    ]

    TEST_POSTS = [
      title: "如何顯示utf8的欄位"
      categories: ["programming"]
      tags: ["mysql"]
      datetime: "2014-03-04 13:10:15"
      link: "mysql-utf8-display"
    ,
      title: "mysql指令一覽"
      categories: ["programming"]
      tags: ["mysql", "cheat_sheet"]
      datetime: "2014-03-04 16:23:26"
      link: "mysql-cheat-sheet"
    ,
      title: "測量mysql query的效能，測試文章如果標題太長的話會不會爆掉爆掉爆掉爆掉爆掉爆掉!!"
      categories: ["tools"]
      tags: ["mysql"]
      datetime: "2014-08-05 12:45:32"
      link: "mysql-profiling-query"
    ,
      title: "Random Token"
      categories: ["programming"]
      tags: ["gem", "works"]
      datetime: "2014-05-14 10:01:17"
      link: "gem-random-token"
    ,
      title: "oh-my-zsh一些實用小技巧"
      categories: ["tools"]
      tags: ["zsh"]
      datetime: "2014-05-07 22:12:34"
      link: "oh-my-zsh-tips"
    ,
      title: "在pow中設定debugger"
      categories: ["tools"]
      tags: ["pow", "debug", "rails"]
      datetime: "2014-05-07 22:12:34"
      link: "setup-debugger-for-pow"
    ,
      title: "如何做到before_render"
      categories: ["programming"]
      tags: ["rails", "rails_controller"]
      datetime: "2014-02-23 13:00:36"
      link: "rails-how-to-before-render"
    ,
      title: "在rails中設置grape"
      categories: ["programming"]
      tags: ["rails", "grape"]
      datetime: "2014-02-28 10:42:57"
      link: "rails-grape-setup"
    ]

    # === post list usage ===

    $scope.getFilteredPosts = ->
      filtered_posts = $filter("orderBy")($scope.posts, "datetime", true)
      if $scope.fp_data.tag.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for tag in post.tags
            if tag in $scope.fp_data.tag
              is_in_list = true
              break
          is_in_list
      if $scope.fp_data.ca.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for ca in post.categories
            if ca in $scope.fp_data.ca
              is_in_list = true
              break
          is_in_list
      filtered_posts

    initVars = ->

    loadPosts = ->
      $scope.posts = TEST_POSTS

    loadTags = ->
      $scope.tags = TEST_TAGS

    loadCategories = ->
      $scope.categories = TEST_CATEGORIES

    init = ->
      $scope.$parent.updateHeaderTitle(APP["header_title"])
      initVars()
      loadPosts()
      loadTags()
      loadCategories()

    init()
]

