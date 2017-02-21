require 'spec_helper'

feature 'Viewing a bill' do
  scenario 'displaying search results' do
    visit('/')
    results = {id: 1, name: "A green door", listing: [ {listing_id: 1, price: 400000, num_bedrooms: 4, property_type: "detached", description: "A stellar porperty", image_url: 'url', thumbnail_url: 'url',details_url: 'url'}, {listing_id: 2, price: 250500, num_bedrooms: 3.5,
      property_type: "terrace", description: "Another stellar porperty", image_url: 'url', thumbnail_url: 'url',details_url: 'url'}]}.to_json
    allow(Net::HTTP).to receive(:get).and_return(results)
    fill_in :location, with: 'bristol'
    fill_in :min_price, with: '10000'
    fill_in :min_price, with: '1000000'
    fill_in :beds, with: '1'
    click_button 'Search'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Displaying results for Bristol'
    expect(page).to have_content 'Asking price: £400000'
  end

  scenario 'displaying full property details' do
    visit('/')
    listing_1 = create_listing
    listing_2 = create_listing(num_bedrooms: 2, description: "Needs some love and attention", price: 250500, property_type: "terrace")
    results = { listing: [listing_1, listing_2 ]}.to_json
    allow(Net::HTTP).to receive(:get).and_return(results)
    search_properties
    click_button 'See more', {id: 1}
    expect(current_path).to eq '/view'
    expect(page).to have_content '2 bedrooms'
    expect(page).to have_content 'terrace property'
    expect(page).to have_content '£250500'
    expect(page).to have_content 'Needs some love and attention'
  end

  scenario 'returning to search results and selecting another listing' do
    visit('/')
    listing_1 = create_listing
    listing_2 = create_listing(num_bedrooms: 2, description: "Needs some love and attention", price: 250500, property_type: "terrace")
    results = { listing: [listing_1, listing_2 ]}.to_json
    allow(Net::HTTP).to receive(:get).and_return(results)
    search_properties
    click_button 'See more', {id: 1}
    expect(current_path).to eq "/view"
    click_button 'Back to results'
    expect(current_path).to eq "/"
    expect(page).to have_content "Asking price: £100000"
  end

end
