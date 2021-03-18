Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :crawlers, only: :index do
   collection do
    post 'crawl_data'
    get 'crawl_data' 
   end 
  end	

  root to: "crawlers#index"
end
