class Api::CurrentTaskController < APIController

  before_filter :ensure_current_task, only: [:show, :done]

  def show
    render :json => task_json
  end

  def create
    @current_task = Task.create_current(task_params)

    render :json => task_json
  end

  def done
    @current_task.close!
    render :nothing => true
  end

  protected

  def ensure_current_task
    @current_task = Task.current
    render status: :not_found, :nothing => true and return unless @current_task
  end

  def task_json
    Jbuilder.encode do |json|
      json.id @current_task._id
      json.name @current_task.name
      json.tags @current_task.tags
      json.work_times @current_task.work_times do |time|
        json.start time.start
        json.end time.end
      end
      json.estimated_seconds @current_task.estimated_seconds.to_i
    end
  end

  private

  def task_params
    params.permit(:name, :estimated_seconds, tags: [])
  end

end
