Rails.application.routes.draw do

  # index page
  root 'now_working#show'

  resource :now_working

end
