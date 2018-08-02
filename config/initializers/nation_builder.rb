if ENV['NATION_NAME'] && ENV['NATION_API_TOKEN']
  $nation_builder_client = NationBuilder::Client.new(ENV['NATION_NAME'], ENV['NATION_API_TOKEN'])
end
