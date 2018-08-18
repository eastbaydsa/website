class MembershipsController < ApplicationController
  before_action :require_nationbuilder_slug

  def check
    email = params[:email].to_s.strip.downcase
    whitelist = ENV['AUTH0_WHITELIST'].split(',')
    if whitelist.include? email
      render json: { status: :found }, status: :ok
    else
      render json: { status: :not_found }, status: :not_found
    end
  end
end
