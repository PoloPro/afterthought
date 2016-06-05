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
  get '/login',             to: "sessons#new"

  # Home/landing pages
  get "instructors/home",   to: "instructors#home"
  get "students/home",      to: "students#home"

  # Lectures routes nested under courses
  resources :courses, only: [:index, :show] do
    resources :lectures, only: [:new, :create, :show]
  end

  # Courses

  # Lectures
  get "lectures/index",     to: "lectures#index",   as: "lectures"

  # Reviews
  get "reviews/index",      to: "reviews#index",    as: "reviews"
  
end
