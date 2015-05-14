require 'net/http'
require 'uri'
require 'cgi'

def submit_url(destination,url_tosubmit) 
  url = URI.parse(destination)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.get('/colla/?url=' + CGI.escape(url_tosubmit) ) 
  }
  puts "Collaserver responded:#{res.body}"
end

def fetch_url(destination) 
  url = URI.parse(destination)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.get('/colla/?topic=any') 
  }
  puts "Collaserver responded:#{res.body}"
  res.body
end

if __FILE__ == $0 #main
  puts 'testing:' + __FILE__
  submit_url('http://localhost:3000' , 'http://www.ruby-lang.org')
  puts fetch_url('http://localhost:3000')
end