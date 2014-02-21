angular.module('YATTApp').factory 'time_by_tags', [
  '$resource',
  ($resource) ->

    $resource('/api/time_by_tags/:action', {}, {
      today: {method: 'GET', params: {action: 'today'}, isArray:true},
      yesterday: {method: 'GET', params: {action: 'yesterday'}, isArray:true},
      this_week: {method: 'GET', params: {action: 'this_week'}, isArray:true},
      last_week: {method: 'GET', params: {action: 'last_week'}, isArray:true},
      this_month: {method: 'GET', params: {action: 'this_month'}, isArray:true},
      last_month: {method: 'GET', params: {action: 'last_month'}, isArray:true},
      between: {method: 'GET', url: '/api/time_by_tags/from/:from/to/:to', isArray: true}
      })

]