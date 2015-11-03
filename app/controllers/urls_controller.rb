class UrlsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
    @urls= Url.all.search(params[:search]) unless params[:id ]# So that urls#index can show all urls created
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)
    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Url was successfully created.' }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def url_shortener_api
    unless request.method == "POST"
        render text: "Please call this API using an HTTP POST request", status: :unprocessable_entity and return
    end

    errors = Array.new
    warnings = Array.new

    # url not present
    unless params["url"].present?
        errors << "URL is required, but not present."
        render text: errors.join(" \n"), status: :unprocessable_entity and return
    end

    # url is short and needs to be parsed
    if params[:url].length > 7 && params[:url].index('tny/')
      tmp_shrt_url = params[:url]
      tmp_shrt_url = tmp_shrt_url[tmp_shrt_url.index('tny/')+4,tmp_shrt_url.length]
      params[:url] = tmp_shrt_url
    end

    # found short url
    if Url.find_by_short_url(params[:url])
      warnings << 'The corresponding long url is: ' + Url.find_by_short_url(params[:url]).long_url
    else
      # Create long URL
      new_url = Url.new(long_url: params[:url])

      if new_url.save
        warnings << 'Short url created is: tny/' + new_url.short_url
      else
        errors << 'Unable to create url'
      end
    end

    if !Url.find_by_short_url(params[:url]) && !Url.find_by_long_url(params[:url])
      errors << 'The url provided came back without results, please try again.'
    end

    unless errors.empty?
        render text: errors.join(" \n"), status: :unprocessable_entity and return
    end

    render :text => warnings.join("\n"), :status => 200

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:long_url, :short_url)
    end
end
