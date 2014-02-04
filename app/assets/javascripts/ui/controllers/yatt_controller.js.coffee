angular.module('YATTApp').controller 'YATTController', [
  '$scope',
  ($scope) ->

    $scope.refresh_all = () ->
      $scope.$broadcast('yatt.refresh')

]