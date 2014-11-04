require 'open-uri'
require 'json'

class ForecastsController < ApplicationController
  def location
    @the_address = params[:address]

    url_safe_address = URI.encode(@the_address)

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_address

    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    results = parsed_data["results"]
    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]


    # Let's store the latitude in a variable called 'the_latitude',
    #   and the longitude in a variable called 'the_longitude'.

    @the_latitude = location["lat"]
    @the_longitude = location["lng"]

    url_weather = "https://api.forecast.io/forecast/f33d281c4d30d6dcd6850cd3bf94f2d2/" + @the_latitude.to_s + "," + @the_longitude.to_s

    raw_data = open(url_weather).read
    parsed_data = JSON.parse(raw_data)
    currently = parsed_data["currently"]

    # Current temperature
    @the_temperature = currently["temperature"]

    # Hour outlook
    hourly = parsed_data["hourly"]
    @the_hour_outlook = hourly["summary"]

    # Next day outlook
    daily = parsed_data["daily"]
    @the_day_outlook = daily["summary"]


  end
end
