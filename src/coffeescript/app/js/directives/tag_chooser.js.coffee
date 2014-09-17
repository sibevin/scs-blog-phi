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
        <div class="tag-opt">
          <input type="checkbox" id="{{tcUid}}_tc_all" name="{{tcUid}}_tag_chooser" value="all" ng-model="tcAllModel" ng-change="onTcAllChange()" />
          <label class="tag-label" for="{{tcUid}}_tc_all">
            <span class="tag-icon">All</span>
          </label>
        </div>
        <div class="tag-opt" ng-repeat="tag in tcTags | orderBy:\'toString()\'">
          <input type="checkbox" id="{{tcUid}}_tc_{{tag}}" name="{{tcUid}}_tag_chooser" value="{{tag}}" ng-model="tcModel[tag]" ng-change="onTcChange()" />
          <label class="tag-label" for="{{tcUid}}_tc_{{tag}}">
            <span class="tag-icon">{{tag}}</span>
          </label>
        </div>
      </div>
      <div class="clearfix" />
    </div>'
