Rails.application.routes.draw do
  get 'sets/definition'
  post 'sets/temp'
  post 'sets/view'
  root 'sets#definition'
end
