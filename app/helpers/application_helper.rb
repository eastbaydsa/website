module ApplicationHelper
  def format_time_range_short start_time, end_time
    format_time_short(start_time) << "-" << format_time_short(end_time)
  end

  def format_time_short time
    text = time.strftime("%-l")
    if time.minute != 0
      text << time.strftime(":%M")
    end
    text << time.strftime("%P")[0,1]
  end
end
