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
  resources 'sessions', only: [:create]
  delete '/signout',           to: 'sessions#destroy'
  get '/login',             to: "sessions#new"

  # Home/landing pages
  get "instructors/home",   to: "instructors#home"
  get "students/home",      to: "students#home"

  # Lectures routes nested under courses
  resources :courses, only: [:index, :show] do
    resources :lectures, only: [:new, :create, :show]
  end

  # Courses
  get '/courses_autocomplete', to: 'courses#courses_autocomplete'
  post "/display_joinable_courses", to: 'courses#display_joinable_courses'
  post "/add_course",           to: "courses#add_course"
  post "/check_course_permissions", to: "courses#check_course_permissions"
  post "/remove_course",        to: "courses#remove_course"
  # Lectures
  get "lectures/index",     to: "lectures#index",   as: "lectures"

  # Reviews
  get "reviews/index",      to: "reviews#index",    as: "reviews"


end
