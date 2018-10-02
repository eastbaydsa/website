class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  def require_nationbuilder_slug
    unless ENV['NATION_SITE_SLUG']
      raise 'You must set NATION_SITE_SLUG in your .env to access this feature.'
    end
  end

  def require_api_key
    unless params[:api_key].present? and ENV['API_KEY'].present? and
        ActiveSupport::SecurityUtils.secure_compare(params[:api_key], ENV['API_KEY'])
      render json: { message: 'Access denied' }, status: :unauthorized
    end
  end
  
  def current_domain
    request.host
  end
  helper_method :current_domain

  def handle_redirect
    redirect_to params[:u]
  end

  def handle_unsubscribe
    redirect_to "https://eastbaydsa.nationbuilder.com/unsubscribe?e=#{params[:e]}&utm_source=#{params[:utm_source]}&utm_medium=#{params[:utm_medium]}&utm_campaign=#{params[:utm_campaign]}&n=#{params[:n]}"
  end

end
