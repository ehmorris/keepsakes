module DaysHelper
  def timestamp_in_range? (timestamp, min, max)
    timestamp.to_i > min.to_i && timestamp.to_i < max.to_i
  end
end
