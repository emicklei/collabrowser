#!/usr/local/bin/ruby
require 'webrick'
include WEBrick

s = HTTPServer.new( :Port => 3000 )

class CollabrowseServlet < HTTPServlet::AbstractServlet
  # process read or update
  def do_GET(req, res)
    
    # submit
    url = req.query['url']
    if url
      $current = url
      self.doFetch(res)
      return   
    end
    
    # fetch
    topic = req.query['topic']
    if topic
       self.doFetch(res)
       return
    end
    
    # report
    self.doReport(res)
  end
  
  def doFetch(res)
      if $current.nil? 
        $current = 'http://www.google.com'
      end
      res['Content-Type'] = "text/plain"
      res.body = $current
  end

  def doReport(res)
      res['Content-Type'] = "text/html"
      page = '<html><body><h2>Collaserver, powered by Ruby</h2>' 
      page << "<h3>now visiting <a href='#{$current}'>#{$current}</a></h3>"
      page << '</body></html>'
      res.body = page      
  end

end


s.mount("/colla", CollabrowseServlet)
trap("INT"){ s.shutdown }
puts 'starting http server'
s.start