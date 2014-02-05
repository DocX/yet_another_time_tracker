Rails.application.routes.draw do

  namespace :api do
  get "time_by_tags/today"
  end

  root 'ui/yatt#main'

  namespace :ui do
  end

  namespace :api, :constraints => {format: 'json'} do
    scope :current_task, controller: :current_task do
      get '/', action: :show
      post '/', action: :create
      delete '/', action: :done
      post '/:id', action: :resume
    end

    scope :work_times, controller: :work_times do
      get '/today', action: :today
    end
  end

end
