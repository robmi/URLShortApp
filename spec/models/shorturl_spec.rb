require 'rails_helper'

RSpec.describe Shorturl, type: :model do
let!(:user) { FactoryGirl.create(:user) }

  it "is valid with a valid url" do
    shorturl = Shorturl.new(original_url: 'http://www.slashdot.org', user_id: user.id)
    expect(shorturl.validate).to be true
    expect(shorturl.errors.messages.any?).to be false
  end

  it "is invalid with a invalid url, no protocol field" do
    shorturl = Shorturl.new(original_url: 'www.slashdot.org', user_id: user.id)
    expect(shorturl.validate).to be false
    expect(shorturl.errors.messages[:original_url][0]).to be == "is invalid"
  end

  it "returns nil for the value of shorturl for an unsaved record" do
    shorturl = Shorturl.new(original_url: 'https://www.slash.org', user_id: user.id)
    expect(shorturl.shorturl.nil?).to be true
  end

  it "returns a string for the value of shorturl for an saved record" do
    shorturl = Shorturl.new(original_url: 'https://www.slash.org', user_id: user.id)
    shorturl.save
    expect(shorturl.shorturl.nil?).to be false
    expect(shorturl.shorturl.class.name).to be == "String"
  end

  it "returns the same the value for shorturl each time" do
    shorturl = Shorturl.new(original_url: 'https://www.sl.org', user_id: user.id)
    shorturl.save
    first_read = shorturl.shorturl
    expect(shorturl.shorturl).to be == first_read
  end

end
