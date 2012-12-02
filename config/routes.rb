PortfolioManager::Application.routes.draw do
  resources :portfolios do
    member do
      post 'price_update'
    end
    resources :assets, :constraints => {:id => /.*/}
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
end
