class Event
  attr_accessor :name, :start_time, :end_time, :description

  def initialize api_response
    self.name = api_response['name']
    self.start_time = DateTime.parse api_response['start_time']
    self.end_time = DateTime.parse api_response['end_time']
    self.description = api_response['intro']
  end
end
