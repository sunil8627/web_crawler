class CrawlersController < ApplicationController

  def index

  end

  def crawl_data
   @url = params[:url]	
   @crawled_data = helpers.parse_data(@url) 
   if @crawled_data.nil?
   	flash[:notice] = "Please enter a valid url"
    redirect_to root_path 
   end

   @crawled_data
  end	

end
