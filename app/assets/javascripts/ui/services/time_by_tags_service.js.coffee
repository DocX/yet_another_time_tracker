angular.module('YATTApp').factory 'time_by_tags', [
  '$resource',
  ($resource) ->

    $resource('/api/time_by_tags/:action', {}, {
      today: {method: 'GET', params: {action: 'today'}, isArray:true},
      })

]