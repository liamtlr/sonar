
describe Search do

  let(:listing) {double(:listing)}

  before do
    listings = ["listing", "listing"]
    result = {country: "England", town: "Harrogate", listing: listings}.to_json
    allow(Net::HTTP).to receive(:get).and_return(result)
  end

  describe '#get_search data' do
    it 'returns search data based on criteria provided in arguments' do
      subject.get_search_data("harrogate", "40000", "100000", "5")
      expect(subject.data).to eq ["listing", "listing"]
    end
    context 'error in API call' do
      it 'sets error instance variable to true if the API call fails' do
        result = {"error_string": "Call failed"}.to_json
        allow(Net::HTTP).to receive(:get).and_return(result)
        subject.get_search_data("harrogate", "40000", "100000", "5")
        expect(subject.error).to eq true
      end
    end
  end

  describe '#populate_listings' do
    it 'receives an array of listings and stores them in a "results" instance variables' do
      listing_data = ["dummy data", "dummy data"]
      result = {country: "England", town: "Harrogate", listing: listing_data}.to_json
      allow(Net::HTTP).to receive(:get).and_return(result)
      allow(listing).to receive(:populate_listing).with "dummy data"
      listings = [listing, listing]
      subject.get_search_data("harrogate", "40000", "100000", "5")
      subject.populate_listings(listings)
      expect(subject.results).to include listing
    end
  end

  describe '#populate_listings' do
    it 'receives an array of listings and stores them in a "results" instance variables' do
      listing_data = ["dummy data", "dummy data"]
      result = {country: "England", town: "Harrogate", listing: listing_data}.to_json
      allow(Net::HTTP).to receive(:get).and_return(result)
      allow(listing).to receive(:populate_listing).with "dummy data"
      listings = [listing, listing]
      subject.get_search_data("harrogate", "40000", "100000", "5")
      subject.populate_listings(listings)
      expect(subject.results).to include listing
    end
  end

  describe '#return_location' do
    it 'capitlizes the location of the search' do
      subject.get_search_data("harrogate", "40000", "100000", "5")
      expect(subject.return_location). to eq "Harrogate"
    end
  end
end
