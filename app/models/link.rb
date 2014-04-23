class Link < ActiveRecord::Base
	has_many :visitors, dependent: :destroy
	
	validates :short_url, presence: true, uniqueness: true
	validates :long_url, presence: true, uniqueness:true, format: {with: URI.regexp, message: "%{value} is not a valid URL"}

end
