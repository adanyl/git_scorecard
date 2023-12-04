Rails.application.routes.draw do
  root 'git_hub_scorecards#index'
  post 'update_score', to: 'git_hub_scorecards#update_score'
end
