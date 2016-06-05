Rails.application.routes.draw do  
  
  root "home#index"

  get "instructors/home", to: "instructors#home"
  get "students/home", to: "students#home"
  
end
