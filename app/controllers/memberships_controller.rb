class MembershipsController < ApplicationController
  before_action :require_nationbuilder_slug, :require_whitelisted_ip

  def check
    email = params[:email].to_s.strip.downcase
    whitelist = ENV['AUTH0_EMAIL_WHITELIST'].split(',')
    if whitelist.include? email
      render json: { status: :found }, status: :ok
    else
      render json: { status: :not_found }, status: :not_found
    end
  end

  private

  def require_whitelisted_ip
    return if ENV['AUTH0_IP_WHITELIST'] == 'disabled'
    whitelist = ENV['AUTH0_IP_WHITELIST'].split(',')
    head :forbidden unless whitelist.include? request.remote_ip
  end
end
