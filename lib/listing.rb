require 'net/http' # remove this
require 'json'
require 'gon-sinatra'

class Listing

  attr_reader :num_bedrooms, :price, :property_type, :description, :remaining_description, :details_url, :image_url, :thumbnail_url

  API_URL = "http://api.zoopla.co.uk/api/v1/property_listings.js?api_key=#{ENV['ZOOPLA_API_KEY']}&"

  def initialize
    @id = nil
    @details = nil
    @num_bedrooms = nil
    @price = nil
    @property_type = nil
    @description = nil
    @image_url = nil
    @details_url = nil
    @remaining_description = nil
    @thumbnail_url = nil
  end

  def populate_listing(details)
    @num_bedrooms = details['num_bedrooms']
    @price = details['price']
    @property_type = details['property_type']
    @description = details['description']
    @image_url = details['image_url']
    @details_url = details['details_url']
    @thumbnail_url = details['thumbnail_url']
    shorten_description
  end

  def shorten_description
    if @description.length > 400
      split_description = [@description[0..399],@description[400..-1] ]
      @description = split_description[0]
      @remaining_description = split_description[1]
    end
  end

end
