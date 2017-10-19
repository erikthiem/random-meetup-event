Rails.application.routes.draw do
  root 'events#random'

  get 'events/random'
end
