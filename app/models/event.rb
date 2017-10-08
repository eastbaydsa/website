class Event
  attr_accessor :title, :start_time, :end_time, :description

  def initialize api_response
    p api_response

    self.title = api_response['name']
    self.start_time = api_response['start_time']
    self.end_time = api_response['end_time']
    self.description = api_response['intro']
  end
end
