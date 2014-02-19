Students::Application.routes.draw do
  root 'public_pages#preparation'

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get '/preparation' => 'public_pages#preparation', as: 'preparation'
  get '/calendar' => 'public_pages#calendar', as: 'calendar'

  get '/dashboard' => 'protected_pages#dashboard', as: 'dashboard'

  get '/feedback' => 'feedback_entries#index', as: 'feedback'

  resources :feedback_entries, only: [:new, :create, :show]
  
  get '/cohorts' => 'cohorts#index', as: 'cohorts'

  namespace :assessments do
    resources :short_answer_quiz_templates
  end
  
end
