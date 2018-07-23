class EventsController < ApplicationController
  before_action :require_nationbuilder_slug

  def index
    # When blank, returns all events
    @tags = params[:tags] || []

    respond_to do |format|

      format.ics do
        @events = Event.query(start_date: 1.month.ago.to_date.to_s, tags: @tags)
        render plain: render_ical(@events, tags: @tags), content_type: 'text/calendar'
      end

      format.html do
        @start_date = Date.parse(params[:start_date]) rescue nil
        @start_date ||= Date.today.beginning_of_month
        params[:start_date] = @start_date.to_s # simple_calendar gem reads from params

        end_date = @start_date.end_of_month

        @events = Event.query(
          start_date: (@start_date - 7.days).to_s,
          end_date: (end_date + 7.days).to_s,
          tags: @tags
        )


        @upcoming_events = @events.select{|e|
          e.start_time > @start_date.to_time.beginning_of_day &&
          e.end_time < end_date.end_of_day
        }.sort_by(&:start_time)

        render layout: 'full_width'
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.ics { render plain: render_ical(@event), content_type: 'text/calendar' }
      format.html
    end
  end

  def rsvp
    @event = Event.find(params[:id])

    begin
      person = nil
      begin
        person = nation_builder_client.call(:people, :push, person: person_params.to_h )
      rescue
        person = nation_builder_client.call(:people, :match, email: person_params.to_h[:email])
      end

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

  def render_ical(events, options = {})
    events = [events] unless events.is_a? Array

    require 'icalendar/tzinfo'
    cal = Icalendar::Calendar.new

    if options[:tags].present?
      cal.x_wr_calname = "East Bay DSA - #{options[:tags].to_sentence}"
    else
      cal.x_wr_calname = 'East Bay DSA'
    end

    if events.present? # add the time zone of the first event (they should all be the same)
      tzid = Event::DEFAULT_TIMEZONE
      zone = TZInfo::Timezone.get(tzid).ical_timezone(events.first.start_time)
      cal.add_timezone zone
    end

    events.each do |event|
      ical_event = event.to_ical(url: event_url(event, slug: event.slug))
      cal.add_event(ical_event)
    end

    cal.publish
    return cal.to_ical
  end

  def person_params
    params.permit(:email, :first_name, :last_name)
  end
end
