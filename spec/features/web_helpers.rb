def search_properties
  visit('/')
  fill_in :location, with: 'bristol'
  fill_in :min_price, with: '10000'
  fill_in :min_price, with: '1000000'
  fill_in :beds, with: '1'
  click_button 'Search'
end

def view_listing
  listing = { listing: [ {price: 400000, num_bedrooms: 4, description: "A lovely cottage", property_type: "Detached"}]}.to_json
  allow(Net::HTTP).to receive(:get).and_return(listing)
  search_properties
  click_button 'See more', {id: 1}
end

def create_listing(listing_id: 1, price: "100000", num_bedrooms: 4, description: "A lovely property", property_type: "Detached", image_url: 'url', thumbnail_url: 'url',details_url: 'url' )
  {listing_id: listing_id, price: price, num_bedrooms: num_bedrooms, description: description, property_type: property_type, image_url: image_url, thumbnail_url: thumbnail_url, details_url: details_url}
end
