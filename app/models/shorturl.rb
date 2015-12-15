class Shorturl < ActiveRecord::Base

  belongs_to :user
  has_many :shortvisits

  validates :original_url, presence: true, allow_blank: false, format: { with: URI.regexp }, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  #convert id to short url
  # TODO: better way ?
  def shorturl
    return nil if self.new_record?
    return self.surl unless self.surl.nil?

    self.surl = encode_url

    self.save
    return surl
  end

  def self.find_by_shorturl(shorturl)
    id = self.decode_url(shorturl)
    self.find(id)
  end

  private

  # TODO: perhaps another algorithm might be better
  def encode_url
    return (id.to_s + (1+rand(8)).to_s).reverse.to_i.base62_encode
  end

  def self.decode_url(shorturl)
    return shorturl.base62_decode.to_s.reverse.chop
  end

end
