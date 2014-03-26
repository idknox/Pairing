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
  resources :cohorts, only: [:index, :show] do
    get :one_on_ones, on: :member
    resources :pairs
    resources :rankings
  end

  resources :job_opportunities, only: [:index, :new, :create, :show, :destroy]

  namespace :assessments do
    resources :quiz_templates do
      post :create_quizzes_for_cohort, on: :member
      post :create_quiz_for_user, on: :member
    end
    resources :quizzes do
      post :submit, on: :member
    end
    get '/quiz_grades/:cohort_id/:quiz_template_id' => 'quiz_grades#summary', as: 'quiz_grades_summary'
    get '/quiz_grades/:cohort_id/:quiz_template_id/:question_index' => 'quiz_grades#question', as: 'quiz_grades_question'
    post '/quiz_grades/:cohort_id/:quiz_template_id/:question_index' => 'quiz_grades#grade_question'
  end
end
