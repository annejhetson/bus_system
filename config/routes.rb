BusTimetable::Application.routes.draw do
  root :to => 'stations#index'

  # get'/stations/:station_slug' => 'stations#show'
  resources :stations, :except => :new

  resources :lines, :except => :new

end
