class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  def nation_builder_client
    unless @nation_builder_client
      unless ENV['NATION_NAME'] && ENV['NATION_API_TOKEN']
        raise "You must set `NATION_NAME` and `NATION_API_TOKEN` in your .env file to use this feature."
      end

      @nation_builder_client = NationBuilder::Client.new(ENV['NATION_NAME'], ENV['NATION_API_TOKEN'])
    end
    @nation_builder_client
  end

  def require_nationbuilder_slug
    unless ENV['NATION_SITE_SLUG']
      raise 'You must set NATION_SITE_SLUG in your .env to access this feature.'
    end
  end

  def handle_redirect
    redirect_to params[:u]
  end

  def handle_unsubscribe
    redirect_to "https://eastbaydsa.nationbuilder.com/unsubscribe?e=#{params[:e]}&utm_source=#{params[:utm_source]}&utm_medium=#{params[:utm_medium]}&utm_campaign=#{params[:utm_campaign]}&n=#{params[:n]}"
  end

end
