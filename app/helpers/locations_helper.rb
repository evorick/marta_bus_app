module LocationsHelper
  # Parse the API data to store it in an array of hashes
  # - each bus is a hash
  def fetch_api_data source
    http = Net::HTTP.get_response(URI.parse(source))
    data = http.body
    JSON.parse(data)
  end

  # Compare the latitude and longitude of the user and all
  # the buses to see if they are within 0.01 degrees ("nearby")
  def is_nearby(user_latitude, user_longitude, bus_latitude, bus_longitude, distance)
    nearby_lat = distance / 69
    nearby_long = distance / 58
    (user_longitude - bus_longitude).abs <= nearby_long && (user_latitude - bus_latitude).abs <= nearby_lat
  end
end
