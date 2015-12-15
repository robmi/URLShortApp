class Base62
  ##
  # Converts a base 10 number to base 62
  #
  # ==== Attributes
  #
  # * +n_base10+ - Base 10 number to convert
  #  
  # ==== Examples  
  #  
  #   Base62.to_base62(123456789)
  def self.to_base62(n_base10)
    init_dictionary if @@dictionary.nil?
    result = ''
    while n_base10 > (@@base - 1)
      place = n_base10 % @@base
      n_base10 /= @@base
      result = @@dictionary[place] + result
    end
    @@dictionary[n_base10] + result    
  end
  
  ##
  # Converts a base 62 number to base 10
  #
  # ==== Attributes
  #
  # * +n_base62+ - Base 62 number to convert
  #
  # ==== Examples  
  #
  #   Base62.to_base10('AbCeF12345')
  def self.to_base10(n_base62)
    init_dictionary if @@dictionary.nil?
    result = 0
    exp = n_base62.size - 1
    n_base62.each_byte do |c|
      curIndex = @@dictionary.index(c.chr)
      result += curIndex * (@@base ** exp)
      exp -= 1
    end
    result
  end
  
  private
  
  @@base = 62
  @@dictionary = nil
  
  def self.init_dictionary
    @@dictionary = [('0'..'9'), 
                    ('a'..'z'), 
                    ('A'..'Z')].map{|r| r.to_a}.flatten
  end 
end






