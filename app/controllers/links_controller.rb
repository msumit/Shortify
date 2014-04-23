class LinksController < ApplicationController
  
  before_action :sanitise_params, only: :create  
  before_action :read_cookies, only: [:index, :create]

  def home
    respond_to do |format|
      format.html
      format.json { render json: {:status => 200, :routes => ['get /links', 'get /links/:short_url', 'post /links'] }}      
    end
  end

  def index
    #@links = Link.joins("LEFT JOIN visitors ON links.id = visitors.link_id")

    all_links = Link.all
    @links = Array.new

    all_links.each do |link|
      @links.push({link: link, visitors: link.visitors})
    end

    respond_to do |format|
      format.html
      format.json { render json: {:status => 200, :links => @links }}      
    end
  end
  
  def show
    link = Link.find_by(short_url: params[:id])
    
    if link
      LocationWorker.perform_async(link.id, request.remote_ip)

      respond_to do |format|
        format.html { redirect_to link.long_url }
        format.json { render json: {:status => 200, :link => link, :visitors => link.visitors }}      
      end
    else
      flash[:error] = 'Oops..there is no such shorty exists..'
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render json: {:status => 400, :errors => 'Short url does not exists'}}      
      end
    end
    
  end
  
  def create
    short_url, exists = shortify(params[:long_url], params[:creator], params[:location])
    status = 200

    if exists
      flash[:notice] = "Voilà...here is your new sweet little shorty: #{root_url + 'links/' + short_url}"
    else    
      link = Link.new(link_params)
      link.short_url = short_url
      
      if link.save
        flash[:notice] = "Voilà...here is your new sweet little shorty: #{root_url + 'links/' +  short_url}"
      else
        flash[:error] = "Oops... #{link.errors.to_a.join(', ')}"
        status = 400
      end 
    end  

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render json: {:status => status, :link => Link.find_by(short_url: short_url), errors: flash[:error] }}      
    end 
    
  end
  
  
  private 
  
  def shortify long_url, creator, location
    link = Link.find_by(long_url: long_url)
    
    if link
      return link.short_url, true 
    else
      begin
        short_url = SecureRandom.hex(3)
      end while !Link.find_by(short_url: short_url).nil?

      return short_url, false
    end       
  end
  
  def link_params
      params.permit(:long_url, :creator, :location)
  end

  def sanitise_params
    if params[:long_url]
      params[:long_url] = 'http://' + params[:long_url] unless /^https?/.match params[:long_url]
      params[:long_url] = URI.escape(params[:long_url])
    end
  end

  def read_cookies
    if params[:long_url]
      cookies[:long_url] = URI.decode(params[:long_url])
    end

    if params[:creator]
      cookies[:creator] = params[:creator]
    else      
      params[:creator] = cookies[:creator]
    end

    if params[:location]
      cookies[:location] = params[:location]
    else
      params[:location] = cookies[:location]
    end
  end
  
end