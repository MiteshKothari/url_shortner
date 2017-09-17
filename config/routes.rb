Rails.application.routes.draw do
	root "shorteners#index"

  resources :shorteners, only: [:index, :create]
  get "/:dilute", to: "shorteners#deflect"
end
