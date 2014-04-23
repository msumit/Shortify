class Visitor < ActiveRecord::Base
  belongs_to :link

  validates :link_id, presence: true, numericality: { only_integer: true }
  validates :ip, presence: true, 
  				format: {with: /\A(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, 
  						message: "%{value} is not a valid IP"}  						
end

