class Event
  attr_accessor :name, :start_time, :end_time, :description

  def initialize api_response
    self.name = api_response['name']
    self.start_time = DateTime.parse api_response['start_time']
    self.end_time = DateTime.parse api_response['end_time']
    self.description = api_response['intro']
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
end
