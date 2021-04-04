Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root "stocks#index", as: "home"

    get "statistica" => "statistica#index"

    resources :stocks do
        resources :products do
            get "move" => "products#move"
            post "move" => "products#move_update"
            get "sell" => "products#sell"
            post "sell" => "products#sell_update"
        end
    end
end
