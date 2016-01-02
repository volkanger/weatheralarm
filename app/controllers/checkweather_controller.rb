require 'forecast_io'

class CheckweatherController < ApplicationController
    
    def index
        #setting forecast api key
        #todo environmental variables
        ForecastIO.api_key = '0a4722abfcc294ac2966f2a1f8240b55'
        
        
        
        #get locations
        @locations = ['11779', '10065', '10017', '06484']
        
        #query the locations
        @locations each do |k|
            lat = k.lat
            long = k.long
            forecast = ForecastIO.forecast(lat, long)
        end
            
        lat = 40.7519846
        long = -73.9697795
        forecast = ForecastIO.forecast(lat, long)
        @icon = forecast.currently.icon
        #@icon = "clear-night"
        if @icon == "clear-night"
          @itrainshere = lat.to_s + "," + long.to_s
        end
        zipcodes = ['11779', '10065', '10017', '06484']
        zipcodes.each do |zipcode|
            @raininghere ||= []
            @raininghere << zipcode
        end
    end
end
