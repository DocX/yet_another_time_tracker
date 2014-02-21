#= require sugar

angular.module('YATTApp').controller 'ReportsController', [
  '$scope', '$timeout', 'time_by_tags', '$location'
  ($scope, $timeout, time_by_tags, $location) ->

    load = () ->
      period = null
      if !$location.search()['to'] or !$location.search()['from']
        period = 'today'
      if $location.search()['period']
        period = $location.search()['period']

      if period
        switch period
          when 'today'
            $scope.current_period_name = 'Today'
            $scope.start = new Date().beginningOfDay()
            $scope.end = new Date().beginningOfDay().addDays(1)
          when 'yesterday'
            $scope.current_period_name = 'Yesterday'
            $scope.start = new Date().beginningOfDay().addDays(-1)
            $scope.end = new Date().beginningOfDay()
          when 'this_week'
            $scope.current_period_name = 'This week'
            $scope.start = new Date().beginningOfISOWeek()
            $scope.end = new Date().beginningOfISOWeek().addDays(7)
          when 'last_week'
            $scope.current_period_name = 'Last week'
            $scope.start = new Date().beginningOfISOWeek().addDays(-7)
            $scope.end = new Date().beginningOfISOWeek()
          when 'this_month'
            $scope.current_period_name = 'This month'
            $scope.start = new Date().beginningOfMonth()
            $scope.end = new Date().beginningOfMonth().addMonths(1)

          when 'last_month'
            $scope.current_period_name = 'Last month'
            $scope.start = new Date().beginningOfMonth().addMonths(-1)
            $scope.end = new Date().beginningOfMonth()
      else
        $scope.start = new Date($location.search()['from'])
        $scope.end = new Date($location.search()['to'])

        diff = $scope.start.daysUntil($scope.end)
        if diff == 1
          $scope.current_period_name = $scope.start.format('short')
        else
          if diff == 7
            $scope.current_period_name = $scope.start.format('short') + ' - ' + $scope.end.format('short')
          else
            $scope.current_period_name = $scope.start.format('{Month} {yyyy}')


      $scope.time_by_tags = time_by_tags.between({
        from: $scope.start.format(Date.ISO8601_DATE),
        to: $scope.end.format(Date.ISO8601_DATE)
        })

    $scope.move_date = (num) ->
      diff = $scope.start.daysUntil($scope.end)
      if diff == 1
        $scope.start.addDays(1 * num)
        $scope.end.addDays(1 * num)
      else
        if diff == 7
          $scope.start.addDays(7 * num)
          $scope.end.addDays(7 * num)
        else
          $scope.start.addMonths(1 * num)
          $scope.end.addMonths(1 * num)

      $location.search({from: $scope.start.toJSON(), to: $scope.end.toJSON()})

    $scope.$on('$locationChangeSuccess', load)
    load()

]