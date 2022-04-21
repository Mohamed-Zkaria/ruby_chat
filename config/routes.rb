Rails.application.routes.draw do

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

  get "/applications/:application_token/chats/:chat_number/messages", to: "messages#index"
  get "/applications/:application_token/chats/:chat_number/messages/:message_number", to: "messages#show"
  post "/applications/:application_token/chats/messages", to: "messages#create"
  patch "/applications/:application_token/chats/:chat_number/messages/:message_number", to: "messages#update"
  put "/applications/:application_token/chats/:chat_number/messages/:message_number", to: "messages#update"
  delete "/applications/:application_token/chats/:chat_number/messages/:message_number", to: "messages#destroy"
  
end
