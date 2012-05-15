class Event < ActiveRecord::Base
  attr_accessible :url_hash, :url_ori
  validates_presence_of :url_ori
end
