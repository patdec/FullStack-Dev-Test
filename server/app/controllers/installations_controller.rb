# frozen_string_literal: true

class InstallationsController < ApplicationController
  def create
    installation = Installation.new(installation_params)
    if installation.save
      head :created
    else
      render json: { error: installation.errors }, status: :unprocessable_entity
    end
  end

  private

  def installation_params
    params.require(:installation).permit(:installer_id, :panels_number, :panels_type, panels_ids: [],
                                         customer_attributes: %i[name email phone],
                                         address_attributes: %i[street city zipcode country_id])
  end
end
