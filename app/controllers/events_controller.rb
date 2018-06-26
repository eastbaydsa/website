class EventsController < ApplicationController
  before_action :require_nationbuilder_slug

  def index
    @start_date = Date.parse(params[:start_date]) rescue nil
    @start_date ||= Date.today.beginning_of_month
    params[:start_date] = @start_date.to_s # simple_calendar gem reads from params

    end_date = @start_date.end_of_month
    # When blank, returns all events
    @tags = params[:tags] || []

    @events = Event.query(
      start_date: (@start_date - 7.days).to_s,
      end_date: (end_date + 7.days).to_s,
      tags: @tags
    )


    @upcoming_events = @events.select{|e|
      e.start_time > @start_date.to_time.beginning_of_day &&
      e.end_time < end_date.end_of_day
    }

    render layout: 'full_width'
  end

  def show
    @event = Event.find(params[:id])
  end

  def rsvp
    @event = Event.find(params[:id])

    begin
      person = nation_builder_client.call(:people, :push, person: person_params.to_h )
      person_id = person['person']['id']

      nation_builder_client.call(:events, :rsvp_create, {
        site_slug: ENV['NATION_SITE_SLUG'],
        id: @event.id,
        rsvp: {
          person_id: person_id
        }
      })

      flash[:success] = 'Thank you for RSVP-ing; see you there!'
    rescue NationBuilder::ClientError => e
      validation_errors = JSON.parse(e.message)['validation_errors'] || []
      if validation_errors.include? 'signup_id has already been taken'
        flash[:success] = 'Thanks for your RSVP - see you there!'
      else
        flash[:error] = 'Something went wrong; please try again, or contact us at info@eastbaydsa.org'
      end
    end

    redirect_to event_path(@event, slug: @event.slug)
  end

protected

  def person_params
    params.permit(:email, :first_name, :last_name)
  end
end
