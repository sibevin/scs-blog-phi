angular.module("scsBlogApp").controller "PostListCtrl", [
  '$scope', '$filter', '$routeParams', '$location'
  ($scope,   $filter,   $routeParams,   $location) ->

    isValidYear = (year_str) ->
      year_str.match(/(\d{4})/)

    isValidMonth = (month_str) ->
      month_value = parseInt(month_str)
      (month_value > 0 && month_value < 13)

    isValidDate = (year_str, month_str, day_str) ->
      d = new Date(year_str + "-" + month_str + "-" + day_str)
      return false if Object.prototype.toString.call(d) != '[object Date]'
      (if isNaN(d) then false else true)

    getStartDate = (year, month = 1, day = 1) ->
      year = parseInt(year)
      month = parseInt(month) - 1
      new Date(year, month, day)

    getEndDate = (year, month = null, day = null) ->
      if month == null
        year = parseInt(year)
        month = 0
        day = 1
        d = new Date(year + 1, month, day)
      else if day == null
        month = parseInt(month) - 1
        day = 1
        d = new Date(year, month + 1, day)
      else
        month = parseInt(month) - 1
        day = parseInt(day)
        d = new Date(year, month, day + 1)
      new Date(d - 1)

    init = ->
      $scope.posts = APP_DATA.posts
      $scope.enableFilterPanel(true)
      options = {}
      time_display = []
      if $routeParams.keyword
        if isValidYear($routeParams.keyword)
          # year only
          query_type = "date"
          query_display = $routeParams.keyword + "年"
          options.start_date = getStartDate($routeParams.keyword)
          options.end_date = getEndDate($routeParams.keyword)
          time_display.push($routeParams.keyword)
        else
          query_type = "keyword"
          query_display = '"' + $routeParams.keyword + '"'
          options.keyword = $routeParams.keyword
      else if $routeParams.year
        # /post/:year/:month or /post/:year/:month/:day
        if isValidYear($routeParams.year)
          year = $routeParams.year
          time_display.push(year)
          if $routeParams.month && isValidMonth($routeParams.month)
            month = $routeParams.month
            time_display.push(month)
            if $routeParams.day && isValidDate(year, month, $routeParams.day)
              # year-month-day
              query_type = "date"
              query_display = year + "∙" + month + "∙" + $routeParams.day
              options.start_date = getStartDate(year, month, $routeParams.day)
              options.end_date = getEndDate(year, month, $routeParams.day)
              time_display.push($routeParams.day)
            else
              # year-month only
              query_type = "date"
              query_display = year + "年" + month + "月"
              options.start_date = getStartDate(year, month)
              options.end_date = getEndDate(year, month)
          else
            # year only
            query_type = "date"
            query_display = year + "年"
            options.start_date = getStartDate(year)
            options.end_date = getEndDate(year)
      else
        # /post
        query_type = "all"

      switch query_type
        when "date"
          $scope.posts_in_where = "所有" + query_display + "的文章("+ options.start_date + " - " + options.end_date + ")"
          $scope.$parent.updateHeaderTitle("文章列表 – " + query_display)
          $scope.options = options
          $scope.title_display = time_display.join("∙")
        when "keyword"
          $scope.posts_in_where = "包含" + query_display + "標題的所有文章"
          $scope.$parent.updateHeaderTitle("文章列表 – 標題包含" + query_display + "的文章")
          $scope.options = options
          $scope.title_display = query_display
        else
          $scope.$parent.updateHeaderTitle("文章列表")

    init()
]
