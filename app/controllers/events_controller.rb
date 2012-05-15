require 'digest/md5'
class EventsController < ApplicationController
	def index
		@events = Event.order("updated_at DESC").all
		@event = Event.new
	end

	def create	
		@event = Event.new(params[:event])
		@old = Event.where( :url_ori => @event.url_ori).first
		if(@old != nil)
			@old.destroy
		end
		@event.url_hash = Digest::MD5.hexdigest(@event.url_ori)[0...8]
		@event.save
		redirect_to :action => :index
	end
	
	def go
		@hash = params[:hashkey]
		@e = Event.where( :url_hash => @hash).first 
		@goto = "http://" + @e.url_ori
		redirect_to @goto
	end
end
