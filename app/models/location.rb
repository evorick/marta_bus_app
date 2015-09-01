class Location < ActiveRecord::Base
  geocoded_by :my_location
  after_validation :geocode # auto-fetch coordinates

  def my_location
    "#{address}, #{city}, GA"
  end

  CITY = ["Atlanta", "Alpharetta", "Avondale Estates", "Chamblee", "Clarkston",
    "College Park", "Decatur", "Doraville", "Dunwoody", "East Point",
    "Fairburn", "Forest Park", "Hapeville", "Lithonia", "Morrow", "Palmetto",
    "Riverdale", "Roswell"," Sandy Springs", "Stone Mountain", "Union City"]
  validates :city, inclusion: CITY
end
