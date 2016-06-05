Rails.application.routes.draw do

  root "home#index"

  # Sessions
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  # Signup pages
  get '/signup',            to: 'student_registrations#new'
  get '/instructor_signup', to: 'instructor_registrations#new'
  resources 'student_registrations',    only: [:create]
  resources 'instructor_registrations', only: [:create]
  resources 'sessions', only: [:create, :destroy]
  get '/login',             to: "sessions#new"

  # Home/landing pages
  get "instructors/home",   to: "instructors#home"
  get "students/home",      to: "students#home"

  # Courses
  get "courses/index",      to: "courses#index"

  # Lectures
  get "lectures/index",      to: "lectures#index"

  # Reviews
  get "reviews/index",      to: "reviews#index"

end
