class MembershipsController < ApplicationController
  include ApplicationHelper
  
  before_action :log_ip, :require_nationbuilder_slug, :require_api_key

  def check
    email = params[:email].to_s.strip.downcase

    if check_membership(email)
      render json: { status: :found }, status: :ok
    else
      render json: { status: :not_found }, status: :not_found
    end
  end

  private

  def log_ip
    email = params[:email] || '[no email provided]'
    logger.info "Memberships#check request received from #{request.remote_ip} for #{email}"
  end
end
