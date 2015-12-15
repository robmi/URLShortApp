require "rails_helper"

RSpec.describe "Shortvisits API" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_2) { FactoryGirl.create(:user, name: "user_2", email: "user2@example.com") }
  let!(:shorturl) do
    FactoryGirl.create(:shorturl, user: user, original_url: "http://www.slashdot.org")
  end
  let!(:shortvisit) do
    FactoryGirl.create(:shortvisit, shorturl: shorturl, ip: "70.36.62.127", city: "Vancouver",
      state: "British Columbia", country: "Canada")
  end
  let!(:shorturl_2) do
    FactoryGirl.create(:shorturl, user: user_2, original_url: "https://www.reddit.com/")
  end
  let!(:shortvisit_2) do
    FactoryGirl.create(:shortvisit, shorturl: shorturl_2, ip: "71.36.62.127", city: "Surrey",
      state: "British Columbia", country: "Canada")
  end
  before do
    user.generate_api_key
  end

  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

    it "retrieves all shortvisits for a given shorturl" do
      get api_shorturl_shortvisits_path(shorturl, format: :json), {}, headers
      expect(response.status).to eq 200
      parsed_r = JSON.parse(response.body )

=begin
      {"data"=>[{"id"=>17, "ip"=>"70.36.62.127", "city"=>"Vancouver",
        "state"=>"British Columbia", "country"=>"Canada"}]}
=end
      expect(parsed_r["data"][0]["id"].class.name).to be == "Fixnum"
      expect(parsed_r["data"][0]["ip"]).to be == "70.36.62.127"
      expect(parsed_r["data"][0]["city"]).to be == "Vancouver"
      expect(parsed_r["data"][0]["state"]).to be == "British Columbia"
      expect(parsed_r["data"][0]["country"]).to be == "Canada"
    end
    it "does not retrieve shortvisits for a given shorturl that belongs to another user" do
      get api_shorturl_shortvisits_path(shorturl_2, format: :json), {}, headers
      expect(response.status).to eq 422
      parsed_r = JSON.parse(response.body )

      expect(parsed_r.empty?).to eq true
    end
    it "retrieves a given shortvisit for a given shorturl" do
      get api_shorturl_shortvisit_path(shorturl, shortvisit, format: :json), {}, headers
      expect(response.status).to eq 200
      parsed_r = JSON.parse(response.body)
=begin
"=>
  {"id"=>45,
   "ip"=>"70.36.62.127",
   "city"=>"Vancouver",
   "state"=>"British Columbia",
   "country"=>"Canada",
   "created_at"=>"2015-12-14T22:42:19.445Z",
   "updated_at"=>"2015-12-14T22:42:19.445Z"}}
=end
      expect(parsed_r["data"]["id"].class.name).to be == "Fixnum"
      expect(parsed_r["data"]["ip"]).to be == "70.36.62.127"
      expect(parsed_r["data"]["city"]).to be == "Vancouver"
      expect(parsed_r["data"]["state"]).to be == "British Columbia"
      expect(parsed_r["data"]["country"]).to be == "Canada"
    end

    it "does not retrieves a given shortvisit for a given shorturl belonging to a different user" do
      get api_shorturl_shortvisit_path(shorturl_2, shortvisit, format: :json), {}, headers

      expect(response.status).to eq 422
      parsed_r = JSON.parse(response.body )

      expect(parsed_r.empty?).to eq true

    end
  end
end
