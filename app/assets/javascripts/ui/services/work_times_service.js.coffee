angular.module('YATTApp').factory 'work_times', [
  '$resource',
  ($resource) ->

    $resource('/api/work_times/:action', {}, {
      today: {method: 'GET', params: {action: 'today'}, isArray: true},
      between: {method: 'GET', url: '/api/work_times/from/:from/to/:to/:page', isArray: false},
      'delete': {method: 'DELETE', url: '/api/work_times/:id'}
      })

]