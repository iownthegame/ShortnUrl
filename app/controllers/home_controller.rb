require 'digest/md5'
class HomeController < ApplicationController
 	def index
		@coo = cookies[:key]
		if(@coo == nil)
			#puts "no cookies key here"
			@key = Digest::MD5.hexdigest(Time.now.to_s)[0...8]
			cookies[:key] = @key
			#puts "assign a new key ", cookies[:key]
		else
			#puts "cookies key is " , @coo
		end
		@events = Event.where( :cookies_key => cookies[:key]).order("updated_at DESC")
	end
	
	def create
 		@url = params[:url]
 		@event = Event.new
                @event.url_ori = @url
		@old = Event.where( :url_ori => @event.url_ori , :cookies_key => cookies[:key]).first
		if(@old != nil)
			@old.destroy
		end
		@event.url_hash = Digest::MD5.hexdigest(@event.url_ori)[0...8]
    		@event.cookies_key = cookies[:key]
		@event.save
		redirect_to '/'
	end
	
	def go
		@hash = params[:hashkey]
		@e = Event.where( :url_hash => @hash ).first
		if(@e.url_ori[0..3] == "http")
			@goto = @e.url_ori
		else
			@goto = "http://" + @e.url_ori
		end
		redirect_to @goto
	end

	

end
