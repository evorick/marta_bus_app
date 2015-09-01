class LocationsController < ApplicationController
  include LocationsHelper # use name of module from that file
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    # MARTA API URL
    source = 'http://developer.itsmarta.com/BRDRestService/RestBusRealTimeService/GetAllBus'

    # Use the helper method to parse the data into an array
    # of hashes for ALL buses in the system
    @buses = fetch_api_data(source)

    # Loop through all buses in system to find those that are
    # nearby and put them into the nearby_buses array
    @nearby_buses = []

    @buses.each do |bus|
      # user_latitude, user_longitude, bus_latitude, bus_longitude
      if is_nearby(@location.latitude, @location.longitude, bus['LATITUDE'].to_f, bus['LONGITUDE'].to_f)
        @nearby_buses.push(bus)
      end
    end

    @bus_count = @nearby_buses.length
    # TODO:  if no buses, return with notice and redirect to enter an address
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :city, :latitude, :longitude)
    end
end
