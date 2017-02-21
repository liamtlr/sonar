describe Listing do

  long_description = 'And overly long description in order to trigger the shorten description method
  And overly long description in order to trigger the shorten description method
  And overly long description in order to trigger the shorten description method
  And overly long description in order to trigger the shorten description method
  And overly long description in order to trigger the shorten description meth'
  hidden_part = 'And this is the bit that should be hidden'
  details = Hash.new
  details["num_bedrooms"] = "3"
  details["price"] = "400,000"
  details["description"] = long_description + hidden_part

  describe '#populate_listing' do
    it 'populates listing instance variables with relevant data' do
      subject.populate_listing(details)
      expect(subject.price).to eq "400,000"
    end
  end

  describe '#shorten_description' do
    it 'splits the description into two halves if over 400 characters long' do
      subject.populate_listing(details)
      expect(subject.remaining_description).to include "And this is the bit that should be hidden"
    end
  end

end
