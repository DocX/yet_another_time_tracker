angular.module('YATTApp').factory 'current_task', [
  '$resource',
  ($resource) ->

    resource = $resource('/api/current_task/:action', {}, {
      get: {method: 'GET', params: {action: ''}},
      create: {method: 'POST', params: {action: ''}},
      close: {method: 'DELETE', params:{action: ''}},
      resume: {method: 'POST', params:{action: '@id'}}
      })

    current_task = null

    {
      $resource: resource,
      get: (callback) ->
        resource.get (new_current_task) ->
          current_task = new_current_task
          callback?(new_current_task)
      create: (task, callback) ->
        resource.create task, (new_current_task) ->
          current_task = new_current_task
          callback?(new_current_task)
      close: (callback) ->
        resource.close()
        current_task = null
        callback?()
      resume: (task, callback) ->
        resource.resume task, (new_current_task) ->
          current_task = new_current_task
          callback?(new_current_task)
      current: () ->
        current_task
      current_total_time: () ->
        if current_task.id?
          current_task_elapsed_seconds = 0
          for time in current_task.work_times
            do (time) ->
              start_value = new Date(time.start).valueOf()
              end_value = if time.end is null then \
                new Date().valueOf() else \
                new Date(time.end).valueOf()

              current_task_elapsed_seconds += (end_value - start_value)

          (current_task_elapsed_seconds / 1000)
        else
          0
      current_split_time: () ->
        if current_task.id?
          split_start = new Date( \
            current_task.work_times[current_task.work_times.length - 1].start \
            ).valueOf()

          (new Date().valueOf() - split_start) / 1000
        else
          0
    }

]