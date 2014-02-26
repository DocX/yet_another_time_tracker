class Api::WorkTimesController < APIController

  def today
    # all tasks with work time today
    @times = of_current_user TaskTime.today.not_running
    @times = @times.desc(:start).to_a

    render :json => times_json
  end

  def between
    @times_all = of_current_user TaskTime.between(DateTime.parse(params[:from]), DateTime.parse(params[:to])).not_running.includes(:task)
    @times_all = @times_all.desc(:start)
    @page = (params[:page] || 0).to_i
    @times = @times_all.skip(@page * 20).take(20).to_a

    render :json => times_json_with_pages
  end

  def destroy
    @time = of_current_user(TaskTime).find(params[:id])

    if @time
      @time.destroy
      render :status => :ok, :nothing => true
    else
      render :status => :not_found, :nothing => true
    end
  end


  protected

  def times_json
    Jbuilder.encode do |json|
      json_times_array(json)
    end
  end

  def times_json_with_pages
    Jbuilder.encode do |json|
      json.pages (@times_all.count / 20.0).ceil
      json.current_page @page
      json.times do
        json_times_array(json)
      end
    end
  end

  def json_times_array(json)
    json.array! @times do |time|
      json.start time.start
      json.end time.end
      json.id time._id.to_s
      json.task do
        json.name  time.task.name
        json.id time.task._id.to_s
        json.estimated_seconds time.task.estimated_seconds
        json.tags time.task.tags
      end
      json.task_elapsed_until_end_of_this  time.task
        .work_times.where(:end.lte => time.end).reduce(0) {|sum,t| sum + ((t.end - t.start) * 86400).to_i }
      json.is_last_of_task time.task.work_times.where(:end.gt => time.end).count == 0
    end
  end
end