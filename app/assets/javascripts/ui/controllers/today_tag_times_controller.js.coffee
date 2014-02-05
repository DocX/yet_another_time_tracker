angular.module('YATTApp').controller 'TodayTagTimesController', [
  '$scope', '$timeout', 'time_by_tags'
  ($scope, $timeout, time_by_tags) ->

    $scope.time_by_tags = time_by_tags.today()

    $scope.$on('yatt.refresh', () ->
      time_by_tags.today (today_time_by_tags) ->
        $scope.time_by_tags = today_time_by_tags
      )

]
