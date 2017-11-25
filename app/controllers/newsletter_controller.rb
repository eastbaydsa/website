class NewsletterController < ApplicationController
  
  @state = nil

  before_action do
    raise 'You must set NATION_SITE_SLUG in your .env to access this feature.' unless ENV['NATION_SITE_SLUG']
  end

  def index
    #nothing to show
  end

  def create
    #POST the newsletter
    userInput = {
      person: {
        email: params[:email],
      }
    }

    #Show an error message if the user accidentally
    #submits a blank form
    if params[:email] == ''
      @state = 'error'
    else
      @newsletter_signup = nation_builder_client.call(:people, :push, userInput)
      person_id = @newsletter_signup['person']['id']
      nation_builder_client.call(:people, :tag_person, {id: person_id, tagging: {tag: 'newsletter'}})
      @state = 'success'
    end
    render :index
  end
end
  