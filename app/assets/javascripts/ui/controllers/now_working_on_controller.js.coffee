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

      task_obj = new current_task
        tags: task_tags
        name: task_match[3]
        estimated_seconds: duration_seconds

      task_obj.$save () ->
        $scope.refresh_all()

      $scope.new_task = ''

    $scope.stop_current_task = () ->
      current_task.close () ->
        $scope.refresh_all()
        $scope.current_task = {}

    set_current_task = () ->
      if $scope.current_task.id?
        current_task_elapsed_seconds = 0
        for time in $scope.current_task.work_times
          do (time) ->
            start_value = new Date(time.start).valueOf()
            end_value = if time.end is null then \
              new Date().valueOf() else \
              new Date(time.end).valueOf()

            current_task_elapsed_seconds += (end_value - start_value)

        $scope.current_task_elapsed_seconds = \
          (current_task_elapsed_seconds / 1000)
        $timeout(set_current_task, 1000)
      else
        $scope.current_task_elapsed_seconds  = null
      $scope.current_task

    $scope.$on('yatt.refresh', () ->
      current_task.get (new_current_task) ->
        $scope.current_task = new_current_task
        set_current_task()
      )

    $scope.new_task = ''
    $scope.current_task = current_task.get () ->
      set_current_task()

    return null

  ]