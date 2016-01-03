class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end


  def saveforlateruse
    #get locations
        locations = Location.all
        
        #query the locations
        locations.each do |k|
            lat = k.lat
            long = k.long
            forecast = ForecastIO.forecast(lat, long)
            
              case forecast.currently.icon 
                when "clear-night"
                  @clearhere ||= []
                  @clearhere << k.zipcode
                when "clear-day"
                  @clearhere ||= []
                  @clearhere << k.zipcode
                when "rain"
                  @rainhere ||= []
                  @rainhere << k.zipcode
                when "snow"
                  @snowhere ||= []
                  @snowhere << k.zipcode
                when "sleet"
                  @sleethere ||= []
                  @sleethere << k.zipcode
                when "wind"
                  @windhere ||= []
                  @windhere << k.zipcodewind
                when "fog"
                  @foghere ||= []
                  @foghere << k.zipcode
                when "cloudy"
                  @cloudyhere ||= []
                  @cloudyhere << k.zipcode
                when "partly-cloudy-day"
                  @partlycloudyhere ||= []
                  @partlycloudyhere << k.zipcode
                when "partly-cloudy-night"
                  @partlycloudyhere ||= []
                  @partlycloudyhere << k.zipcode  
                else
                  @elsehere ||=[]
                  @elsehere << k.zipcode
              end
          end
        if @clearhere.nil?
          @clearhere = ["nowhere"]
        end
        if @rainhere.nil?
          @rainhere = ["nowhere"]
        end
        if @snowhere.nil?
          @snowhere = ["nowhere"]
        end
        if @elsehere.nil?
          @elsehere = ["nowhere"]
        end
        if @sleethere.nil?
          @sleethere = ["nowhere"]
        end
        if @windhere.nil?
          @windhere = ["nowhere"]
        end
        if @foghere.nil?
          @foghere = ["nowhere"]
        end
        if @cloudyhere.nil?
          @cloudyhere = ["nowhere"]
        end
        if @partlycloudyhere.nil?
          @partlycloudyhere = ["nowhere"]
        end
  end



  def checkweather
        #setting forecast api key
        #todo environmental variables
        ForecastIO.api_key = '0a4722abfcc294ac2966f2a1f8240b55'
        
        #get locations
        locations = Location.all
      
        #get recipes
        recipes = Recipe.all.where('active' => 1)
        
        locations.each do |l|
          lat = l.lat
          long = l.long
          f = ForecastIO.forecast(lat, long)
          recipes.each do |r|
            if r.precipIntensityStart.present?
              if f.currently.precipIntensity >= r.precipIntensityStart
              else next
              end
            end
            if r.precipIntensityEnd.present?
              if f.currently.precipIntensity <= r.precipIntensityEnd
              else next 
              end
            end
            if r.precipProbabilityStart.present?
              if f.currently.precipProbability >= r.precipProbabilityStart
              else next
              end
            end
            if r.precipProbabilityEnd.present?
              if f.currently.precipProbability <= r.precipProbabilityEnd
              else next
              end
            end
            if r.precipType.present?
              if f.currently.precipType == r.precipType
              else next
              end
            end
            if r.temperatureStart.present?
              if f.currently.temperature >= r.temperatureStart
              else next
              end
            end
            if r.temperatureEnd.present?
              if f.currently.temperature <= r.temperatureEnd
              else next
              end
            end
            if r.apparentTemperatureStart.present?
              if f.currently.apparentTemperature >= r.apparentTemperatureStart
              else next
              end
            end
            if r.apparentTemperatureEnd.present?
              if f.currently.apparentTemperature <= r.apparentTemperatureEnd
              else next
              end
            end
            if r.windSpeedStart.present?
              if f.currently.windSpeed >= r.windSpeedStart
              else next
              end
            end
            if r.windSpeedEnd.present?
              if f.currently.windSpeed <= r.windSpeedEnd
              else next
              end
            end
            if r.humidityStart.present?
              if f.currently.humidity >= r.humidityStart
              else next
              end
            end
            if r.humidityEnd.present?
              if f.currently.humidity <= r.humidityEnd
              else next
              end
            end
            if r.pressureStart.present?
              if f.currently.pressure >= r.pressureStart
              else next
              end
            end
            if r.pressureEnd.present?
              if f.currently.pressure <= r.pressureEnd
              else next
              end
            end
            @result ||= []
            @result << [r.id, l.zipcode]
          end
        end
        flash[:notice] = "Calculation completed."
        UserMailer.welcome(2).deliver_now
  end

  def geo
    conn = Faraday.new(:url => 'http://maps.googleapis.com/maps/api/geocode/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    
    response = conn.get 'json', { :address => :zipcode }     # GET http://sushi.com/nigiri/sake.json
    response.body
    
    profile = JSON.parse(response.body)
    @lat = profile['results'].first['geometry']['location']['lat']
    @long = profile['results'].first['geometry']['location']['lng']

  end


  # GET /locations/1
  # GET /locations/1.json
  def show
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
    
    
    
    
    conn = Faraday.new(:url => 'http://maps.googleapis.com/maps/api/geocode/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    
    response = conn.get 'json', { :address => @location.zipcode }
    response.body
    
    profile = JSON.parse(response.body)
    @location.lat = profile['results'].first['geometry']['location']['lat']
    @location.long = profile['results'].first['geometry']['location']['lng']
    
    
    
    
    

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
      params.require(:location).permit(:lat, :long, :zipcode)
    end
end
