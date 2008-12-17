require 'uri'
require 'net/http'

module ActualURL
  SHORTENED_URL_HOSTS = ['tinyurl.com', 'is.gd', 'tr.im', 'notlong.com', 'metamark.net']
  
  def self.is_tiny?(url)
    u = URI.parse(url)
    SHORTENED_URL_HOSTS.include? u.host
  rescue URI::InvalidURIError
    false
  end
  
  def self.resolve(url)
    return url unless is_tiny?(url)
   
    # make a request and, if 302'd you know what to do.
    u = URI.parse(url)
    http = Net::HTTP.new(u.host)
    resp = http.get(u.request_uri, nil)
    resp.response['Location']
  end
  
end
  