class Shortvisit < ActiveRecord::Base
  belongs_to :shorturl

  validates :shorturl_id, presence: true
  validates :ip, presence: true

  private

  #TODO error handling
  def self.geolocate(id)
    shortvisit = self.find(id)

    response = HTTParty.get("http://freegeoip.net/json/#{shortvisit.ip}")
    resp_h = JSON.parse(response.body)

    shortvisit.city = resp_h['city']
    shortvisit.state = resp_h['region_name']
    shortvisit.country = resp_h['country_name']

    shortvisit.save
  end

end
