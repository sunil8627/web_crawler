module CrawlersHelper

 def parse_data(url)

  unparsed_page = HTTParty.get(url)
  parsed_doc = Nokogiri::HTML(unparsed_page)
  css    = ["CSS", parsed_doc.css(%{link[type="text/css"]}).map{|node| node["href"]}.compact]
  js     = ["Javascript", parsed_doc.css(%{script}               ).map{|node| node["src"] }.compact]
  images = ["Images", parsed_doc.css(%{img}                  ).map{|node| node["src"] }.compact]

  links  = ["Links", parsed_doc.css(%{a}                    ).map{|node| node["href"]}.compact.map{|l|
      parse_url(l, url)
    }.compact.map(&:to_s).uniq.sort]

  [css, js, images, links]
 rescue
   return nil 
 end	

 def parse_url(current_link, url)
    current_link_host = URI.parse(current_link).host
    return nil if current_link_host.nil?
    url_host = URI.parse(url).host
    return nil unless (current_link_host.include? url_host) if (current_link_host)
    current_link
 rescue URI::InvalidURIError
    logger.warn "Invalid URL: #{current_link}"
    return nil   
 end
end
