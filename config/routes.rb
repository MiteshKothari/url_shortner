Rails.application.routes.draw do
	root "shorteners#index"

  resources :shorteners, only: [:index, :create] do
    collection do
      get :find
    end
  end
  get "/:dilute", to: "shorteners#deflect"
end
