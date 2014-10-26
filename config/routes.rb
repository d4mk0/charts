Rails.application.routes.draw do

  get 'part_answers', to: 'charts#part_answers'
  get 'dynamic', to: 'charts#dynamic'
  get 'part', to: 'charts#part'

  root to: 'home#index'
end
