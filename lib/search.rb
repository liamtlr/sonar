require 'net/http'
require 'json'

class Search

  attr_reader :results, :return_location, :error, :data

  API_URL = "http://api.zoopla.co.uk/api/v1/property_listings.js?api_key=#{ENV['ZOOPLA_API_KEY']}&"

  def self.instance
    @search ||= Search.new
  end

  def initialize
    @data = nil
    @location = nil
    @min_price = nil
    @max_price = nil
    @beds = nil
    @results = []
    @error = false
  end

  def get_search_data(location, min_price, max_price, beds)
    assign_instance_variables(location, min_price, max_price, beds)
    url = API_URL + "area=#{@location}&min_price=#{@min_price}&max_price=#{@max_price}&minimum_beds=#{@beds}&description_style=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    results = JSON.parse(response)
    results['error_string'] ? @error = true : @error = false
    @data = results["listing"]
  end

  def populate_listings(listings)
    @results = []
    listing_and_details = listings.zip(@data)
    listing_and_details.each do|listing|
      listing[0].populate_listing(listing[1])
      @results << listing[0]
    end
  end

  def return_location
    @location.capitalize
  end

  private

  def assign_instance_variables(location, min_price, max_price, beds)
    @location = location
    @min_price = min_price
    @max_price = max_price
    @beds = beds
  end
end
