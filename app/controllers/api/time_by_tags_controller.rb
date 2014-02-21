class Api::TimeByTagsController < APIController
  def today
    # get times today
    @times = of_current_user TaskTime.today.includes(:task)

    @tags_times = {}
    @times.each do |time|
      time.task.tags.each do |tag|
        @tags_times[tag] ||= 0
        @tags_times[tag] += time.end.nil? ? 0 : ((time.end - time.start) * 86400).to_i
      end
    end

    render :json => tags_times_json
  end


  protected
  def tags_times_json
    Jbuilder.encode do |json|
      json.array! @tags_times do |tag|
        json.tag tag.first
        json.seconds tag.second
      end
    end
  end
end
