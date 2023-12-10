class ShortLinksController < ApplicationController
  before_action :set_short_link, only: %i[ show edit update destroy ]

  # GET /short_links or /short_links.json
  def index
    @short_links = ShortLink.all
  end

  # GET /short_links/1 or /short_links/1.json
  def show
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
