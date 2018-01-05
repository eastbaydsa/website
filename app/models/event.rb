class Event
  attr_accessor :id, :name, :start_time, :end_time, :description, :venue, :address

  def initialize api_response
    self.id = api_response['id']
    self.name = api_response['name']
    self.start_time = DateTime.parse api_response['start_time']
    self.end_time = DateTime.parse api_response['end_time']
    self.description = api_response['intro']
    self.venue = api_response['venue']['name']
    self.address = api_response['venue']['address'] || {}
  end

  def address_string
    x = [
      [
        address['address1'],
        address['address2'],
        address['address3'],
      ],
      [
        address['city'],
        address['state'],
        address['zip'],
      ]
    ].map { |segment| segment.reject{ |e| e.to_s.empty? }.join(', ') }
     .join('<br />')

  end

  def map_location_string
    [
      venue,
      address['address1'],
      address['address2'],
      address['address3'],
      address['city'],
      address['state'],
      address['zip'],
    ].reject { |e| e.to_s.empty? }
     .join(',')
     .sub(' ', '+')
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

  def self.query(start_date, end_date = nil, limit = nil)
    opts = {
      site_slug: ENV['NATION_SITE_SLUG'],
      starting: start_date,
      limit: 1000
    }
    opts[:until] = end_date if end_date

    @events = client.call(:events, :index, opts)["results"]
      .select{ |e| e["published_at"] != nil }
      .map{ |e| Event.new(e) }
      # .maxListLength...
  end

  def self.find(id)
    raw = client.call(:events, :show, {
      site_slug: ENV['NATION_SITE_SLUG'],
      id: id
    })

    Event.new(raw['event'])
  end
end
