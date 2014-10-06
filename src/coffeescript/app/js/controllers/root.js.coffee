angular.module("scsBlogApp").controller "RootCtrl", [
  '$scope', '$filter', 'TabSwitcher'
  ($scope,   $filter,   TabSwitcher) ->
    getDateArr = (post) ->
      date_arr = post.datetime.match(/(\d{4})-(\d{2})-(\d{2})/)
      _.rest(date_arr)

    $scope.showTag = (name) ->
      name.replace(/_/g, " > ")

    $scope.showTagCount = (tag) ->
      if APP_DATA.tags[tag]
        APP_DATA.tags[tag].count
      else
        0

    $scope.showCa = (name) ->
      name

    $scope.showCaCount = (ca) ->
      if APP_DATA.categories[ca]
        APP_DATA.categories[ca].count
      else
        0

    $scope.getDateLink = (post, kind) ->
      date_arr = getDateArr(post)
      link = "#/post/"
      result = switch kind
        when "y" then (_.initial(date_arr, 2)).join("/")
        when "m" then (_.initial(date_arr, 1)).join("/")
        when "d" then date_arr.join("/")
      link + result

    $scope.getPostLink = (post) ->
      date_arr = getDateArr(post)
      "#/post/" + date_arr.join("/") + "/" + post.link

    $scope.getDateValue = (post, kind) ->
      date_arr = getDateArr(post)
      result = switch kind
        when "y" then date_arr[0]
        when "m" then date_arr[1]
        when "d" then date_arr[2]
      result

    $scope.updateHeaderTitle = (title) ->
      $scope.header_title = title

    $scope.enableFilterPanel = (is_on) ->
      $scope.enable_fp = is_on

    $scope.showFp = ->
      $scope.enable_fp && $scope.menu_ts.isTab("fp")

    $scope.getFilteredPosts = (all_posts, options = null) ->
      filtered_posts = $filter("orderBy")(all_posts, "datetime", true)
      if $scope.fp_data.tag.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for tag in post.tag
            if tag in $scope.fp_data.tag
              is_in_list = true
              break
            for sub_tag in tag.split("_")
              if sub_tag in $scope.fp_data.tag
                is_in_list = true
                break
            break if is_in_list
          is_in_list
      if $scope.fp_data.ca.length > 0
        filtered_posts = $filter("filter") filtered_posts, (post) ->
          is_in_list = false
          for ca in post.category
            if ca in $scope.fp_data.ca
              is_in_list = true
              break
            for sub_ca in ca.split("_")
              if sub_ca in $scope.fp_data.ca
                is_in_list = true
                break
            break if is_in_list
          is_in_list
      if $scope.fp_data.keyword != ""
        filtered_posts = $filter("filter")(filtered_posts, $scope.fp_data.keyword)
      if options
        if options.start_date
          filtered_posts = $filter("filter") filtered_posts, (post) ->
            d = new Date(post.datetime)
            (d >= options.start_date)
        if options.end_date
          filtered_posts = $filter("filter") filtered_posts, (post) ->
            d = new Date(post.datetime)
            (d < options.end_date)
        if options.keyword
          filtered_posts = $filter("filter")(filtered_posts, options.keyword)
      filtered_posts

    initVars = ->
      $scope.brand = APP["brand"]
      $scope.author = APP["author"]
      $scope.footer_trademark = APP["footer_trademark"]
      $scope.menu_ts = new TabSwitcher("close")
      $scope.enable_fp = true # false
      $scope.fp_data = {}
      $scope.fp_data.ca = []
      $scope.fp_data.tag = []
      $scope.fp_data.keyword = ""

    init = ->
      initVars()

    init()
]
