task :import_redirect_csv do
  # Look for .csv file in lib/tasks/eastbaydsa-redirects.csv
  puts "Starting: #{Redirect.count} redirects in the system."

  succeeded = []
  failed = []

  CSV.foreach("lib/tasks/eastbaydsa-redirects.csv") do |row|
    redirect_from_path = row[0]
    redirect_to_path = row[1]

    # only process lines where the first characters of both paths are a leading slash:
    if redirect_from_path[0] == '/' and redirect_to_path[0] == '/'
      r = Redirect.new(from_path: redirect_from_path, to_url: redirect_to_path)
      if r.save
        succeeded << row
      else
        failed << row
      end
    else
      failed << row
    end
  end

  # all done!
  puts "Attempted #{failed.count + succeeded.count} rows. #{failed.count} failed and #{succeeded.count} suceeded."

  puts "#{Redirect.count} redirects now in the system."

  puts "#{failed.count} failed rows:"
  failed.each do |r|
    puts "#{r.first} => #{r.last}"
  end

  puts "#{succeeded.count} succeeded rows:"
  succeeded.each do |r|
    puts "#{r.first} => #{r.last}"
  end

end
