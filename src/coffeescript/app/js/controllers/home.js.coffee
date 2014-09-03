angular.module("scsBlogApp").controller "HomeCtrl", [
  '$scope', '$filter'
  ($scope,   $filter) ->
    TEST_CATEGORIES = ["programming", "life", "css", "tools"]

    TEST_TAGS = ["rails", "angularjs", "gem", "works", "rails_controller", "mysql", "pow", "debug"]

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
      title: "測量mysql query的效能"
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

    # === filter callbacks ===

    $scope.onCfAllChange = ->
      $scope.filtered_cas = []
      $scope.ca_filter_all = true
      $scope.ca_filter[ca] = false for ca in $scope.categories

    $scope.onCfChange = ->
      $scope.filtered_cas = _.keys(_.omit $scope.ca_filter, (value) ->
        return value == false
      )
      if $scope.filtered_cas.length > 0
        $scope.ca_filter_all = false
      else
        $scope.onCfAllChange()

    $scope.onTfAllChange = ->
      $scope.filtered_tags = []
      $scope.tag_filter_all = true
      $scope.tag_filter[tag] = false for tag in $scope.tags

    $scope.onTfChange = ->
      $scope.filtered_tags = _.keys(_.omit $scope.tag_filter, (value) ->
        return value == false
      )
      if $scope.filtered_tags.length > 0
        $scope.tag_filter_all = false
      else
        $scope.onTfAllChange()

    # === post list usage ===

    $scope.getFilteredPosts = ->
      filtered_posts = $filter("orderBy")($scope.posts, "datetime", true)
      if $scope.filtered_tags.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for tag in post.tags
            if tag in $scope.filtered_tags
              is_in_list = true
              break
          is_in_list
      if $scope.filtered_cas.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for ca in post.categories
            if ca in $scope.filtered_cas
              is_in_list = true
              break
          is_in_list
      filtered_posts

    getDateArr = (post) ->
      date_arr = post.datetime.match(/(\d{4})-(\d{2})-(\d{2})/)
      _.rest(date_arr)

    $scope.getDateLink = (post, kind) ->
      date_arr = getDateArr(post)
      link = "#/"
      result = switch kind
        when "y" then (_.initial(date_arr, 2)).join("/")
        when "m" then (_.initial(date_arr, 1)).join("/")
        when "d" then date_arr.join("/")
      link + result

    $scope.getPostLink = (post) ->
      date_arr = getDateArr(post)
      "#/" + date_arr.join("/") + "/" + post.link

    $scope.getDateValue = (post, kind) ->
      date_arr = getDateArr(post)
      result = switch kind
        when "y" then date_arr[0]
        when "m" then date_arr[1]
        when "d" then date_arr[2]
      result

    initVars = ->
      $scope.ca_filter = {}
      $scope.tag_filter = {}
      $scope.filtered_cas = []
      $scope.filtered_tags = []

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
      $scope.onCfAllChange()
      $scope.onTfAllChange()

    init()
]

