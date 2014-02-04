Rails.application.routes.draw do

  root 'ui/yatt#main'

  namespace :ui do
  end

  namespace :api, :constraints => {format: 'json'} do
    scope :current_task, controller: :current_task do
      get '/', action: :show
      post '/', action: :create
      delete '/', action: :done
    end

    scope :work_times, controller: :work_times do
      get '/today', action: :today
    end
  end

end
