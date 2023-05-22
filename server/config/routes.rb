# frozen_string_literal: true

Rails.application.routes.draw do

  scope defaults: { format: 'json'} do
    resources :installations, only: :create
  end
end
