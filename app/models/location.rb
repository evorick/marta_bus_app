class Location < ActiveRecord::Base
  geocode_by :my_location
  after_validation :geocode # auto-fetch coordinates

  def my_location
    "#{address}, #{city}, GA"
  end
end
