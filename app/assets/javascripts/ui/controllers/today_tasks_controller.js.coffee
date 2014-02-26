angular.module('YATTApp').controller 'TodayTasksController', [
  '$scope', '$timeout', 'work_times'
  ($scope, $timeout, work_times) ->

    $scope.today_times = work_times.today()

    $scope.$on('yatt.refresh', () ->
      work_times.today (today_times) ->
        $scope.today_times = today_times
      )

]
