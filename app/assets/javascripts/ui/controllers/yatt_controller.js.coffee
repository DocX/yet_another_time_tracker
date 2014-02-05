angular.module('YATTApp').controller 'YATTController', [
  '$scope', 'current_task'
  ($scope, current_task) ->

    $scope.refresh_all = () ->
      $scope.$broadcast('yatt.refresh')

    $scope.resume_task = (task) ->
      current_task.resume(id: task.id, (current_task) ->
        $scope.refresh_all()
      )

]