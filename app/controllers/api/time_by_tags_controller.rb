class Api::TimeByTagsController < APIController

  def today
    # get times today
    @times = of_current_user TaskTime.today.includes(:task)

    render_times
  end

  def yesterday
    @times = of_current_user TaskTime.between(
      DateTime.now.to_date - 1,
      DateTime.now.to_date)
      .includes(:task)

    render_times
  end

  def this_week
    monday = DateTime.now.to_date - ((DateTime.now.to_date.wday - 1) % 7)
    @times = of_current_user TaskTime.between(monday, monday + 7)
      .includes(:task)

    render_times
  end

  def last_week
    monday = DateTime.now.to_date - ((DateTime.now.to_date.wday - 1) % 7)
    @times = of_current_user TaskTime.between(monday - 7, monday)
      .includes(:task)

    render_times
  end

  def this_month
    first = DateTime.now.to_date - DateTime.now.to_date.mday + 1
    last = first + 1.month
    @times = of_current_user TaskTime.between(first, last)
      .includes(:task)

    render_times
  end

  def last_month
    first = DateTime.now.to_date - DateTime.now.to_date.mday + 1 - 1.month
    last = first + 1.month
    @times = of_current_user TaskTime.between(first, last)
      .includes(:task)

    render_times
  end

  def between
    @times = of_current_user TaskTime.between(DateTime.parse(params[:from]), DateTime.parse(params[:to]))
      .includes(:task)

    render_times
  end


  protected

  def aggregate_tags
    @tags_times = {}
    @times.each do |time|
      time.task.tags.each do |tag|
        @tags_times[tag] ||= 0
        @tags_times[tag] += time.end.nil? ? 0 : ((time.end - time.start) * 86400).to_i
      end
    end
  end

  def render_times
    aggregate_tags
    render :json => tags_times_json
  end

  def tags_times_json
    Jbuilder.encode do |json|
      json.array! @tags_times do |tag|
        json.tag tag.first
        json.seconds tag.second
      end
    end
  end
end
