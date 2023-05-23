# frozen_string_literal: true

class CountriesController < ApplicationController
  def index
    @countries = Country.order(:name).all
  end
end
