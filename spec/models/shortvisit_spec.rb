require 'rails_helper'

RSpec.describe Shortvisit, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:shorturl) do
    FactoryGirl.create(:shorturl, user: user, original_url: "http://www.slashdot.org")
  end

    it "is valid with a shorturl, and an ip address " do
      shortvisit = Shortvisit.new(shorturl: shorturl, ip: "70.36.62.127")
      expect(shortvisit.validate).to be true
      expect(shortvisit.errors.messages.any?).to be false
    end

    it "is invalid with a shorturl, and no ip address " do
      shortvisit = Shortvisit.new(shorturl: shorturl)
      expect(shortvisit.validate).to be false
      expect(shortvisit.errors.messages.any?).to be true
      expect(shortvisit.errors.messages[:ip][0]).to be == "can't be blank"
    end

    it "is invalid with an ip, and shorturl " do
      shortvisit = Shortvisit.new(ip: "70.36.62.127")
      expect(shortvisit.validate).to be false
      expect(shortvisit.errors.messages.any?).to be true
      expect(shortvisit.errors.messages[:shorturl_id][0]).to be == "can't be blank"
    end

    it "can retrieve the location data by the geolocate method" do
      shortvisit = Shortvisit.create(shorturl: shorturl, ip: "70.36.62.127")
      expect(shortvisit.city.nil?).to be true

      Shortvisit.geolocate(shortvisit.id)

      shortvisit = Shortvisit.find(shortvisit.id)

      expect(shortvisit.city).to be == "Vancouver"
      expect(shortvisit.state).to be == "British Columbia"
      expect(shortvisit.country).to be == "Canada"

    end
end
