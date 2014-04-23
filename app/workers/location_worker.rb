class LocationWorker 
  include Sidekiq::Worker

  def perform(link_id, ip)
    visitor =  JSON(Net::HTTP.get('freegeoip.net', "/json/#{ip}"))
	
	if visitor
	  link = Link.find(link_id)
      link.visitors.create(visitor.slice("ip", "country_code", "country_name", "region_code", "region_name", "city", "zipcode", "latitude", "longitude"))
    end
  end
end