Rails.application.routes.draw do

  root "home#index"

  # Sessions
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  # Signup pages
  get "/signup",                    to: "student_registrations#new"
  get "/instructor_signup",         to: "instructor_registrations#new"
  resources "student_registrations",    only: [:create]
  resources "instructor_registrations", only: [:create]
  resources "sessions", only: [:create]
  delete "/signout",                to: "sessions#destroy"
  get "/login",                     to: "sessions#new"

  # Home/landing pages
  get "instructors/home",           to: "instructors#home"
  get "students/home",              to: "students#home"

  # Lectures routes nested under courses
  resources :courses, only: [:index, :show, :new, :create] do
    resources :lectures, only: [:new, :create, :show]
  end

  # Courses
  post "/remove_course",            to: "courses#remove_course"

  #CourseAutocomplete
  get "/courses_autocomplete",      to: "course_autocompletes#courses_autocomplete"
  post "/display_joinable_courses", to: "course_autocompletes#display_joinable_courses"
  post "/check_course_permissions", to: "course_autocompletes#check_course_permissions"
  post "/add_course",               to: "course_autocompletes#add_course"

  # Lectures
  get "lectures/index",             to: "lectures#index",   as: "lectures"

  # Reviews
  resources :reviews, only: [:index, :create, :destroy]
  post "/reviews/anonymous",        to: "reviews#make_review_anonymous"
  post "/reviews/named",            to: "reviews#make_review_named"
  post "/feedback/send",            to: "feedback#collate_and_send"

  #Students
  get "/student_autocomplete",      to: "students#student_autocomplete"

  #Enrollments
  resources :enrollments, only: [:create]
  get '/enrollments/:confirmation_token' => 'enrollments#confirm_email', as: 'enrollment_confirmation'
end
