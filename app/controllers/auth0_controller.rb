class Auth0Controller < ApplicationController
  include ApplicationHelper
  
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    email = request.env['omniauth.auth']['extra']['raw_info']['https://example.com/email'].to_s.strip.downcase  # the tag is weird because auth0 won't return the tag without adding a rule and the tag has to be weird...
    if check_membership(email)
      session[:userinfo] = request.env['omniauth.auth']
    end
    
    # Redirect to the URL you want after successful auth
    redirect_to '/'
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
  
  def logout
    session.delete(:userinfo)
    redirect_to '/'
  end
end