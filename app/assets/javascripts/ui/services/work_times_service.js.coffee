angular.module('YATTApp').factory 'work_times', [
  '$resource',
  ($resource) ->

    $resource('/api/work_times/:action', {}, {
      today: {method: 'GET', params: {action: 'today'}, isArray: true},
      })

]