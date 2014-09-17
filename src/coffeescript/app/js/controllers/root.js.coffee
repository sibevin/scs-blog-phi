angular.module("scsBlogApp").controller "RootCtrl", [
  '$scope', 'TabSwitcher'
  ($scope,   TabSwitcher) ->
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

    $scope.updateHeaderTitle = (title) ->
      $scope.header_title = title

    $scope.showFp = ->
      $scope.enable_fp && $scope.menu_ts.isTab("fp")

    initVars = ->
      $scope.brand = APP["brand"]
      $scope.author = APP["author"]
      $scope.footer_trademark = APP["footer_trademark"]
      $scope.menu_ts = new TabSwitcher("close")
      $scope.enable_fp = true # false
      $scope.fp_data = {}
      $scope.fp_data.ca = []
      $scope.fp_data.tag = []

    init = ->
      initVars()

    init()
]
