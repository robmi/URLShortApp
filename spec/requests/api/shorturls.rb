require "rails_helper"

RSpec.describe "Shorturl API" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_2) { FactoryGirl.create(:user, name: "user_2", email: "user2@example.com") }
  let!(:shorturl) do
    FactoryGirl.create(:shorturl, user: user, original_url: "http://www.slashdot.org")
  end
  let!(:shorturl_2) do
    FactoryGirl.create(:shorturl, user: user_2, original_url: "https://www.reddit.com/")
  end
  before do
    user.generate_api_key
  end
  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end
    it "retrieves all shorturls for a given user" do
      get api_user_shorturls_path(user, format: :json), {}, headers
      expect(response.status).to eq 200
      parsed_r = JSON.parse(response.body )

      # {"data"=>[{"id"=>1, "original_url"=>"http://www.slashdot.org",
      # "shorturl"=>"z", "visits_count"=>0, "user_id"=>1}]}
      expect(parsed_r["data"][0]["id"].class.name).to be == "Fixnum"
      expect(parsed_r["data"][0]["original_url"]).to be == "http://www.slashdot.org"
      expect(parsed_r["data"][0]["shorturl"].size).to be <= 2
      expect(parsed_r["data"][0]["visits_count"]).to be == 0
      expect(parsed_r["data"][0]["user_id"]).to be == user.id
    end
    it "does not retrieve all shorturls for a given other user" do
      get api_user_shorturls_path(user_2, format: :json), {}, headers
      expect(response.status).to eq 422
      parsed_r = JSON.parse(response.body )

      expect(parsed_r.empty?).to eq true
    end
    it "retrieves a given shorturl for a given user it belongs to" do
      get api_user_shorturl_path(user, shorturl, format: :json), {}, headers
      expect(response.status).to eq 200
      parsed_r = JSON.parse(response.body )
=begin
{"data"=>
  {"id"=>25,
   "original_url"=>"http://www.slashdot.org",
   "shorturl"=>"8u",
   "visits_count"=>0,
   "user_id"=>48,
   "created_at"=>"2015-12-14T20:38:39.237Z",
   "updated_at"=>"2015-12-14T20:38:39.258Z"}}
=end
      expect(parsed_r["data"]["id"].class.name).to be == "Fixnum"
      expect(parsed_r["data"]["original_url"]).to be == "http://www.slashdot.org"
      expect(parsed_r["data"]["shorturl"].size).to be <= 2
      expect(parsed_r["data"]["visits_count"]).to be == 0
      expect(parsed_r["data"]["user_id"]).to be == user.id
    end
    it "does not retrieve a given shorturl for a given user it does not belongs to" do
      get api_user_shorturl_path(user_2, shorturl_2, format: :json), {}, headers
      expect(response.status).to eq 422
      parsed_r = JSON.parse(response.body )

      expect(parsed_r.empty?).to eq true

    end
  end
end
