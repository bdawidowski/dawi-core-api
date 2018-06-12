Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :auth, to: "authentication#create"
      post :register, to: "registration#create"
    end
  end
end
