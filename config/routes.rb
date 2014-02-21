Rails.application.routes.draw do

  devise_for :users

  root 'ui/yatt#main'
  get '/about', to: 'ui/yatt#about'
  get '/reports', to: 'ui/yatt#reports'

  namespace :api, :constraints => {format: 'json'} do
    scope :time_by_tags, controller: :time_by_tags do
      get "/today", action: :today
      get "/yesterday", action: :yesterday
      get "/this_week", action: :this_week
      get "/last_week", action: :last_week
      get "/this_month", action: :this_month
      get "/last_month", action: :last_month
      get "/from/:from/to/:to", action: :between
    end

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
