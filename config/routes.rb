Rails.application.routes.draw do
  root 'events#show'

  get 'events/show'
end
