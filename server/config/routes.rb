# frozen_string_literal: true

Rails.application.routes.draw do

  scope defaults: { format: 'json'} do
    resources :countries, only: :index
    resources :installations, only: :create
    resources :installers, only: :index
  end
end
