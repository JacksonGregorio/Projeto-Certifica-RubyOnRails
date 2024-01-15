Rails.application.routes.draw do
    resources :users
    post '/auth/login', to: 'authentication#login' 

   
    
    #users
    post '/create/user', to: 'users#create'
    get '/get/all/user', to: 'users#index'
    get '/get/user/:id', to: 'users#show'
    put '/update/user/:id', to: 'users#update'
    delete '/delete/user/:id', to: 'users#destroy'


    #certificates
    get '/filters/certificate', to: 'certificates#list_filters'
    get '/filters/certificate/expired', to: 'certificates#list_filters_expired'
    post '/create/certificate', to: 'certificates#create'
    get '/get/all/certificate', to: 'certificates#index'
    get '/get/certificate/:id', to: 'certificates#show'
    put '/update/certificate/:id', to: 'certificates#update'
    delete '/delete/certificate/:id', to: 'certificates#destroy'

    #companies
    post '/create/company', to: 'companies#create'
    get '/get/all/company', to: 'companies#index'
    get '/get/company/:id', to: 'companies#show'
    put '/update/company/:id', to: 'companies#update'
    delete '/delete/company/:id', to: 'companies#destroy'



  get '/*a', to: 'application#not_found'
  get "up" => "rails/health#show", as: :rails_health_check
end
