class Location < ActiveRecord::Base
  geocoded_by :my_location
  after_validation :geocode # auto-fetch coordinates

  def my_location
    "#{address}, #{city}, GA"
  end
end
