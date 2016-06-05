Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get '/signup', to: 'student_registrations#new'
  get '/instructor_signup', to: 'instructor_registrations#new'
  resources 'student_registrations', only: [:create]
  resources 'instructor_registrations', only: [:create]
  get '/login', to: "sessons#new"

  root "home#index"

end
