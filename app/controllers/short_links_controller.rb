class ShortLinksController < ApplicationController
  before_action :set_short_link, only: %i[ show edit update destroy ]

  # GET /short_links or /short_links.json
  def index
    @short_links = ShortLink.all
  end

  # GET /short_links/1 or /short_links/1.json
  def show
  end

  # GET /access/1 or /short_links/1.json
  def access
    @short_link = ShortLink.where('short_url': params[:short_url])[0]

    @password_validated = false
    @messages = ""

    @password = params.has_key?(:password) ? params.require(:password) : ""

    if @password and @password == @short_link.password
      
      @password_validated = true

    else

      if @password != ""

        @password_validated = false
        @messages = "Incorrect password."

      end

    end

  end

  def validate_password

    @short_link = ShortLink.where('short_url': params[:short_url])[0]

    @password_validated = false
    @messages = ""

    @password = params.has_key?(:password) ? params.require(:password) : ""

    if @password and @password == @short_link.password
      
      @password_validated = true
      # redirect_to @short_link.url

    else

      if @password != ""

        @password_validated = false
        @messages = "Incorrect password."

      end

    end

  end

  # GET /short_links/new
  def new
    @short_link = ShortLink.new
  end

  # GET /short_links/1/edit
  def edit
  end

  # POST /short_links or /short_links.json
  def create
    @short_link = ShortLink.new(short_link_params)
    @short_link.short_url = Digest::SHA256.hexdigest(@short_link.url + current_user.id.to_s).first(7)

    unless @short_link.url.include?("http://") || @short_link.url.include?("https://")
      @short_link.url = "http://" + @short_link.url
    end

    if @short_link.expiration_date
      @e_date = @short_link.expiration_date
      @short_link.expiration_date = DateTime.new(@e_date.year, @e_date.month, @e_date.day, 0, 0, 0)
    end

    respond_to do |format|
      if @short_link.save
        format.html { redirect_to short_link_url(@short_link), notice: "Short link was successfully created." }
        format.json { render :show, status: :created, location: @short_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @short_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /short_links/1 or /short_links/1.json
  def update
    respond_to do |format|
      if @short_link.update(short_link_params)
        format.html { redirect_to short_link_url(@short_link), notice: "Short link was successfully updated." }
        format.json { render :show, status: :ok, location: @short_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @short_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_links/1 or /short_links/1.json
  def destroy
    @short_link.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Short link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def decrease_usages
    if @short_link.usages
      @short_link.usages -= 1
      @short_link.save
    end
    return nil
  end
  helper_method :decrease_usages

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_link
      @short_link = ShortLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def short_link_params
      params.require(:short_link).permit(:user_id, :short_url, :url, :expiration_date, :password, :usages)
    end
end
