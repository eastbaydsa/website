class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action do
    @menu = MenuItem.all
  end
end
