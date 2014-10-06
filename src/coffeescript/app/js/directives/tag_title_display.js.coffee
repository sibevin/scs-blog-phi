angular.module("scsBlogApp").directive "tagTitleDisplay", ->
  restrict: 'EA'
  replace: true
  scope:
    ttdModel: "="
  template: '
    <span class="tag-title-display">
      <span ng-repeat="sub_title_tag in sub_tags">
        <span ng-show="$index > 0"> &gt; </span>
        <a href="#/tag/{{ sub_title_tag.link }}">
          {{ sub_title_tag.name }}
        </a>
      </span>
    </div>'
  controller: ($scope, $element, $attrs) ->
    init = ->
      $scope.sub_tags = []
      sub_names = $scope.ttdModel.split("_")
      sub_links = []
      for sub_name in sub_names
        sub_links.push(sub_name)
        $scope.sub_tags.push(
          name: sub_name
          link: sub_links.join("_")
        )
    init()

