module ApplicationHelper
  def formatted_time(time)
    time + Time.now.in_time_zone('Moscow').utc_offset
  end

end


