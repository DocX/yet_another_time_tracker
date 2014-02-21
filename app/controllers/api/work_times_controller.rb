class Api::WorkTimesController < APIController

  def today
    # all tasks with work time today
    @times = of_current_user TaskTime.today.not_running
    @times = @times.desc(:start).to_a

    render :json => times_json
  end


  protected

  def times_json
    Jbuilder.encode do |json|
      json.array! @times do |time|
        json.start time.start
        json.end time.end
        json.task do
          json.name  time.task.name
          json.id time.task._id.to_s
          json.estimated_seconds time.task.estimated_seconds
          json.tags time.task.tags
        end
      end
    end
  end
end