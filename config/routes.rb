Rails.application.routes.draw do

  devise_for :users

  root 'ui/yatt#main'
  get '/about', to: 'ui/yatt#about'
  get '/reports', to: 'ui/yatt#reports'

  namespace :api, :constraints => {format: 'json'} do
    get "time_by_tags/today"

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
