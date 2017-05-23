Rails.application.routes.draw do

  resources :settlement_rules do
    resources :settlement_prices
    member do
      put :refresh_products
      get :download
      get :upload
      post :upload
    end
  end

  resources :product_items
  resources :vouchers
  resources :user_card_charge_settings do
    collection do
      post :pay
      post :getList
    end
  end

  resources :order_promotions
  resources :user_promotions
  resources :category_promotions
  resources :promotion_rules
  resources :coupon_lists

  resources :coupons do
    collection do
      post :createCoupon
      post :getUsedCoupon
      post :getUnusedCoupon
      post :getInvalidCoupon
    end
  end
  resources :coupon_lists do
    collection do
      post :getList
    end
    resources :order_promotions, only: [:new, :create, :edit, :update, :destroy, :show]
    resources :user_promotions, only: [:new, :create, :edit, :update, :destroy, :show]
    resources :category_promotions, only: [:new, :create, :edit, :update, :destroy, :show]
    resources :promotion_rules
  end

  resources :user_card_logs do
    collection do
      post :getList
    end
    end

  resources :user_cards do
    collection do
      post :getUserCard
    end
  end
  resources :items do
    collection do
      post :createItem
    end
  end

  devise_for :workers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :workers do 
    member do 
      get :reset_password
      put :change_current_city
      post :login
    end
  end
  resources :users  do
    resources :orders
    resources :user_cards do
      member do
        get :charge
        post :charge
      end
    end
    resources :coupons
  end

  resources :couriers
  resources :factories do
    resources :factory_settlement_rules
    member do
      get :settlement_detail
    end
  end

  resources :roles

  resources :categories do 
    resources :products
    member do 
      get :prices
      post :init_prices
    end
  end

  resources :prices

  resources :price_rules do
    collection do
      post :getPriceRules
    end
  end

  resources :stations do 
    collection do 
      get :suggestion
    end
  end

  resources :regions do 
    collection do 
      get :search
    end
  end

  resources :addresses do 
    collection do 
      get :suggestion
      post :createAddress
      post :getAddressByUser
    end
  end
  resources :cities

  resources :orders do
    resources :waybills
    member do 
      post :paidan
    end
    collection do
      post :sendOrder
      post :createOrder
      post :getOrderByUser
      post :pay
      post :getOrderByCourier
      post :getOrderByFactory
      post :sendToFactory
    end
  end

  resources :waybills do
    collection do
      post :fightWaybill
    end
  end
end
