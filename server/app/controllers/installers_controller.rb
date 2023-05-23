# frozen_string_literal: true

class InstallersController < ApplicationController
  def index
    @installers = Installer.order(:name).all
  end
end
