class MembershipsController < ApplicationController
  before_action :require_nationbuilder_slug, :require_whitelisted_ip

  def check
    email = params[:email].to_s.strip.downcase

    # need to rescue from the API call, cause it throws an error if not found
    person = $nation_builder_client.call(:people, :match, email: email) rescue nil
    national_member = person['person']['tags'].include?('national_member') rescue false
    
    whitelist = ENV['AUTH0_EMAIL_WHITELIST'].to_s.split(',')

    if national_member or whitelist.include?(email)
      render json: { status: :found }, status: :ok
    else
      render json: { status: :not_found }, status: :not_found
    end
  end

  private

  def require_whitelisted_ip
    return if ENV['AUTH0_IP_WHITELIST'].nil? or ENV['AUTH0_IP_WHITELIST'] == 'disabled'
    whitelist = ENV['AUTH0_IP_WHITELIST'].split(',')
    head :forbidden unless whitelist.include? request.remote_ip
  end
end
