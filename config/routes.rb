Students::Application.routes.draw do
  root 'public_pages#preparation'

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get '/preparation' => 'public_pages#preparation', as: 'preparation'
  get '/calendar' => 'public_pages#calendar', as: 'calendar'

  get '/dashboard' => 'protected_pages#dashboard', as: 'dashboard'

  get '/feedback' => 'feedback_entries#index', as: 'feedback'

  get '/pre-test' => 'pre_tests#show', as: 'pre_test'
  post '/pre-test' => 'pre_tests#create'
  patch '/pre-test/submit' => 'pre_tests#submit', as: 'submit_pre_test'

  get '/pre-test/:question_id' => 'pre_tests#question', as: :pre_test_question
  post '/pre-test/:question_id' => 'pre_tests#update_answer'

  resources :feedback_entries, only: [:new, :create, :show]
end
