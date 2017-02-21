require 'sinatra/base'
require 'gon-sinatra'
require_relative 'search'
require_relative 'listing'

class Sonar < Sinatra::Base

  register Gon::Sinatra

  set :sessions, true

  before do
    @search = Search.instance
  end

  get '/' do
    erb :index
  end

  post '/' do
    if params[:location]
      @search.get_search_data(params[:location], params[:min_price], params[:max_price], params[:beds])
      unless @search.error
        listings = []
        @search.data.length.times{ listings << Listing.new }
        @search.populate_listings(listings)
      end
    end
    @listings = @search.results
    erb :index
  end

  post '/view' do
    @listing = @search.results[params[:index].to_i]
    gon.remaining_description = @listing.remaining_description
    erb :index
  end

  run! if app_file == $0

end
