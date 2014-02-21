angular.module('YATTApp').controller 'NowWorkingOnController', [
  '$scope', '$timeout', 'current_task'
  ($scope, $timeout, current_task) ->


    $scope.enter_new_task = () ->
      # parse string via regexp
      task_pattern =
        new RegExp '^((#\\w+ )*)(.+) ((\\d+)d)?((\\d+)h)?((\\d+)m)?$'

      task_match = task_pattern.exec($scope.new_task)
      if not task_match?
        $scope.new_task_error = true
        return false

      task_tags = for tag in task_match[1].split(' ') when tag isnt ''
        tag.slice(1)

      duration_seconds = 0
      # days
      duration_seconds += task_match[5] * 86400 if task_match[5]?
      # hours
      duration_seconds += task_match[7] * 3600 if task_match[7]?
      # minutes
      duration_seconds += task_match[9] * 60 if task_match[9]?

      task_obj = new current_task.$resource
        tags: task_tags
        name: task_match[3]
        estimated_seconds: duration_seconds

      current_task.create task_obj, () ->
        $scope.refresh_all()

      $scope.new_task = ''

    $scope.stop_current_task = () ->
      current_task.close () ->
        $scope.refresh_all()


    refresh_time = () ->
      if $scope.current_task.current()
        #$scope.$apply()
        $scope.current_task = $scope.current_task
        $timeout(refresh_time, 1000)

    $scope.$on('yatt.refresh', () ->
      current_task.get (new_current_task) ->
        refresh_time()
      )

    $scope.new_task = ''
    $scope.current_task = current_task
    current_task.get (n) ->
      refresh_time()

    $('button[data-toggle=popover]').popover()

    return null

  ]