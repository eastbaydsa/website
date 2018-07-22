class Event
  # If EBDSA ever has events outside this timezone,
  # the calendar integration might not work properly
  DEFAULT_TIMEZONE = 'US/Pacific'
  TAGS = {
    'meeting' => 'Meetings',
    'canvass' => 'Canvasses',
    'phonebank' => 'Phone banks',
    'other' => 'Other' # <- Catch-all for rest of our tags, and events e/o any tags
  }

  attr_accessor :id, :name, :start_time, :end_time, :description, :venue, :address, :image_url, :tags, :accept_rsvps

  def initialize api_response
    self.id = api_response['id']
    self.name = api_response['name']
    self.start_time = DateTime.parse api_response['start_time']
    self.end_time = DateTime.parse api_response['end_time']
    self.description = api_response['intro'] # FIXME: get non-html version?
    self.venue = api_response['venue']['name']
    self.address = api_response['venue']['address'] || {}
    self.image_url = api_response['meta_image_url'] # FIXME: image URL not returned!
    self.tags = api_response['tags']
    self.accept_rsvps = api_response['rsvp_form']['accept_rsvps']
  end

  def to_param; id; end

  def slug
    "#{start_time.to_date}-#{name}".parameterize
  end

  def to_ical(options = {})
    ical_event = Icalendar::Event.new
    ical_event.dtstart     = Icalendar::Values::DateTime.new start_time, 'tzid' => DEFAULT_TIMEZONE
    ical_event.dtend       = Icalendar::Values::DateTime.new end_time, 'tzid' => DEFAULT_TIMEZONE
    ical_event.summary     = name
    ical_event.description = ActionView::Base.full_sanitizer.sanitize(description)
    ical_event.url         = options[:url]
    ical_event.location    = full_address
    ical_event
  end

  def gcal_url
    require 'uri'
    uri = URI.parse('https://www.google.com/calendar/event')
    uri.query = URI.encode_www_form(
      action: 'TEMPLATE',
      text: name,
      details: ActionView::Base.full_sanitizer.sanitize(description),
      location: full_address,
      dates: "#{start_time.strftime('%Y%m%dT%H%M%S')}/#{end_time.strftime('%Y%m%dT%H%M%S')}"
    )
    uri.to_s
  end

  def full_address
    fields = [ 'address1', 'address2', 'address3', 'city', 'state', 'zip' ]
    fields.map{|field| address[field] }.select(&:present?).join(', ')
  end

  def self.client
    unless @nation_builder_client
      unless ENV['NATION_NAME'] && ENV['NATION_API_TOKEN']
        raise "You must set `NATION_NAME` and `NATION_API_TOKEN` in your .env file to use this feature."
      end

      @nation_builder_client = NationBuilder::Client.new(ENV['NATION_NAME'], ENV['NATION_API_TOKEN'])
    end
    @nation_builder_client
  end

  def self.query(start_date: Date.today, end_date: nil, limit: 500, tags: [])
    opts = {
      site_slug: ENV['NATION_SITE_SLUG'],
      starting: start_date,
      limit: 500 # NationBuilder API doesn't return sorted events, so just grab a bunch
    }
    opts[:until] = end_date if end_date

    # NationBuilder API doesnt seem to actually work
    # when passed multiple tags (it just returns all events)
    # Instead, let's just filter with tags after the API
    # call responds
    tags = tags.clone
    other = tags.delete 'other'

    @events = client.call(:events, :index, opts)["results"]
      .select{ |e| ['published', 'expired'].include?(e['status']) }
      .sort_by{ |e| e['start_time']} # NationBuilder API returns unsorted events
      .take(limit)
      .map{ |e| Event.new(e) }
      .select{ |event|
        next true if tags.blank? and other.blank? # return all events if no tags provided
        # normal tags - event shares one of the provided tags:
        (tags & event.tags).present? or
        # 'other' category - event lacks any of our listed tags, but other was checked:
        ((TAGS.keys & event.tags).blank? && other)
      }
  end

  def self.find(id)
    raw = client.call(:events, :show, {
      site_slug: ENV['NATION_SITE_SLUG'],
      id: id
    })

    Event.new(raw['event'])
  end
end
