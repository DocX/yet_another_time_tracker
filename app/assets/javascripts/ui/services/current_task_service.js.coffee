angular.module('YATTApp').factory 'current_task', [
  '$resource',
  ($resource) ->

    $resource('/api/current_task/:action', {}, {
      get: {method: 'GET', params: {action: ''}},
      create: {method: 'POST', params: {action: ''}},
      close: {method: 'DELETE', params:{action: ''}}
      })

]