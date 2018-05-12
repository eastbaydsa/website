  class Event
  attr_accessor :id, :name, :start_time, :end_time, :description, :venue, :address, :image_url

  def initialize api_response
    self.id = api_response['id']
    self.name = api_response['name']
    self.start_time = DateTime.parse api_response['start_time']
    self.end_time = DateTime.parse api_response['end_time']
    self.description = api_response['intro'] # FIXME: get non-html version?
    self.venue = api_response['venue']['name']
    self.address = api_response['venue']['address'] || {}
    self.image_url = api_response['meta_image_url'] # FIXME: image URL not returned!
  end

  def to_param; id; end

  def slug
    "#{start_time.to_date}-#{name}".parameterize
  end

  def full_address
    fields = [ 'address1', 'address2', 'address3', 'city', 'state', 'zip' ]
    fields.map{|field| address[field] }.tap{|a| a.unshift(venue) }.select(&:present?).join(', ')
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

  def self.query(start_date, end_date = nil, limit = 1000)
    opts = {
      site_slug: ENV['NATION_SITE_SLUG'],
      starting: start_date,
      limit: limit
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
