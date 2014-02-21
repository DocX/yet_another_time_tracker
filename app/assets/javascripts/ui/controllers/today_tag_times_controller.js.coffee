angular.module('YATTApp').controller 'TodayTagTimesController', [
  '$scope', '$timeout', 'time_by_tags', 'current_task',
  ($scope, $timeout, time_by_tags, current_task) ->

    $scope.time_by_tags = time_by_tags.today()

    $scope.$on 'yatt.refresh', () ->
      time_by_tags.today (today_time_by_tags) ->
        $scope.time_by_tags = today_time_by_tags

    $scope.current_task_tag_seconds = (tag) ->
      if current_task.current()
        tags = (ctag for ctag in current_task.current().tags when ctag == tag)
        if tags.length > 0
          return current_task.current_split_time()
        else
          0
      else
        0


]
