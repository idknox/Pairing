Students::Application.routes.draw do
  root to: redirect("/preparation")

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get '/preparation' => 'public_pages#preparation', as: 'preparation'
  get '/calendar' => 'public_pages#calendar', as: 'calendar'

  get '/dashboard' => 'protected_pages#student_dashboard', as: 'student_dashboard'
  get '/class_info' => 'protected_pages#class_info', as: 'class_info'
  get '/instructor_dashboard' => 'instructors#dashboard', as: 'instructor_dashboard'

  get '/feedback' => 'feedback_entries#index', as: 'feedback'

  get '/my_assignments' => 'students/assignments#index', as: :my_assignments

  resources :feedback_entries, only: [:new, :create, :show]
  resources :cohorts, only: [:index, :show] do
    get :one_on_ones, on: :member
    resources :pairs
    resources :rankings
    resources :students, only: [:new, :create]
    resources :assignments, only: [:index, :new, :show, :create], controller: 'cohort_assignments'
  end

  resources :assignments, only: [:new, :create] do
    resources :submissions
  end

  resources :job_opportunities

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

  namespace :clicker do
    get '/' => 'location#new'
    get '/:location' => 'role#new', as: :new_role
    get '/:location/instructor' => 'instructor#show', as: :instructor
    get '/:location/instructor/boot' => 'instructor#boot'
    post '/:location/instructor/reset' => 'instructor#reset'
    get '/:location/student' => 'student#show', as: :student
    post '/:location/student/you-lost-me' => 'student#you_lost_me'
    post '/:location/student/caught-up' => 'student#caught_up'
  end
end
