angular.module("scsBlogApp").directive "tagChooser", ->
  restrict: 'EA'
  replace: true
  scope:
    tcUid: "@"
    tcTags: "="
    tcModel: "="
    tcAllModel: "="
    onTcAllChange: "&"
    onTcChange: "&"
  template: '
    <div class="tag-filter">
      <div class="tag-opt">
        <input type="checkbox" id="{{tcUid}}_tc_all" name="{{tcUid}}_tag_chooser" value="all" ng-model="tcAllModel" ng-change="onTcAllChange()" />
        <label class="tag-label" for="{{tcUid}}_tc_all">
          <span class="tag-icon">All</span>
        </label>
      </div>
      <div class="tag-opt" ng-repeat="tag in tcTags | orderBy:\'name\'">
        <input type="checkbox" id="{{tcUid}}_tc_{{tag.name}}" name="{{tcUid}}_tag_chooser" value="{{tag.name}}" ng-model="tcModel[tag.name]" ng-change="onTcChange()" />
        <label class="tag-label" for="{{tcUid}}_tc_{{tag.name}}">
          <span class="tag-icon">{{showTag(tag.name)}}</span>
        </label>
      </div>
      <div class="clearfix" />
    </div>'
  controller: [
    "$scope", "$element", "$attrs"
    ($scope,   $element,   $attrs) ->
      $scope.showTag = (name) ->
        name.replace(/_/g, " > ")
  ]
