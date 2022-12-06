Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'

  get '/states', to: 'states#index'
  get 'states/new', to: 'states#new'
  post '/states', to: 'states#create'
  get '/states/:id', to: 'states#show'
  get '/states/:id/edit', to: 'states#edit'
  patch '/states/:id', to: 'states#update'
  delete '/states/:id', to: 'states#destroy'

  get '/cities', to: 'cities#index'
  get '/cities/:id', to: 'cities#show'
  get '/cities/:id/edit', to: 'cities#edit'
  patch '/cities/:id', to: 'cities#update'
  delete '/cities/:id', to: 'cities#destroy'

  get '/states/:state_id/cities', to: 'state_cities#index'
  get '/states/:state_id/cities/new', to: 'state_cities#new'
  post '/states/:state_id/cities', to: 'state_cities#create'
  delete '/states/:state_id/cities/:city_id', to: 'state_cities#destroy'
end
