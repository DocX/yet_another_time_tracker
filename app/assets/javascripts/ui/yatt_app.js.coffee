YATTApp = angular.module('YATTApp', ['ngResource'])

YATTApp.config ['$httpProvider', ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  ]

YATTApp.directive 'ngEnter', () ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which is 13
        scope.$apply () ->
          scope.$eval(attrs.ngEnter, {'event': event})

        event.preventDefault()

YATTApp.filter 'humanizeSeconds', () ->
  (seconds) ->
    seconds = Math.floor(Number(seconds))

    if Math.abs(seconds) <= 60
      return Math.abs(seconds) + 's'

    total_minutes = Math.abs(Math.floor(seconds / 60 ))
    minutes = total_minutes % 60
    hours = Math.floor(total_minutes / 60) % 24
    days = Math.floor(total_minutes / 1440)



    return (if days > 0 then days + 'd' else '') + \
      (if hours > 0 then hours + 'h' else '') + \
      minutes + 'm'

