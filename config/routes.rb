BusTimetable::Application.routes.draw do
  root :to => 'stations#index'

  get'/stations' => 'stations#index'

  resources :stations, :except => :new
  resources :lines, :except => :new

end
