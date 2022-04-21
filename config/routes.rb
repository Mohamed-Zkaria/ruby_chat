Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :applications do
  #   resources :chats do
  #     resources :messages
  #   end
  # end

  get "/applications", to: "applications#index"
  get "/applications/:token", to: "applications#show"
  post "/applications", to: "applications#create"
  patch "/applications/:token", to: "applications#update"
  put "/applications/:token", to: "applications#update"
  delete "applications/:token", to: "applications#destroy"

  get "/applications/:application_token/chats/", to: "chats#index"
  get "/applications/:application_token/chats/:chat_number", to: "chats#show"
  post "/applications/:application_token/chats/", to: "chats#create"
  patch "/applications/:application_token/chats/:chat_number", to: "chats#update"
  put "/applications/:application_token/chats/:chat_number", to: "chats#update"
  delete "/applications/:application_token/chats/:chat_number", to: "chats#destroy"
  
end
