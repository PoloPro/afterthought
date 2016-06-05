Rails.application.routes.draw do

  get '/signup', to: 'student_registrations#new'
  get '/instructor_signup', to: 'instructor_registrations#new'
  resources 'student_registrations', only: [:create]
  resources 'instructor_registrations', only: [:create]

  root "home#index"

end
