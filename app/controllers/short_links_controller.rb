class ShortLinksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :edit, :create, :update, :destroy, :index]
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
    @short_link = ShortLink.find_by(short_url: params[:short_url])

    if  @short_link.expiration_date and @short_link.expiration_date.to_date <= Date.today
      @message = "The link that you are trying to access has expired."
      render 'unavailable_access'
    else
      if @short_link.usages and @short_link.usages.to_i <= 0
        @message = "The link that you are trying to access has no usages left."
        render 'unavailable_access'
      else
        if @short_link.password != ""
          render 'password_protected_access'
        else
          render 'access'
        end
      end
    end
  end

  def validate_password

    @short_link = ShortLink.find_by(short_url: params[:short_url])

    if params[:password] == @short_link.password
      
      decrease_usages()
      generate_report()
      redirect_to @short_link.url, allow_other_host: true

    else

      redirect_to '/l/' + @short_link.short_url, :flash => { :error => "Incorrect Password." }

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

    if @short_link.save
      redirect_to short_link_url(@short_link), notice: "Short link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /short_links/1 or /short_links/1.json
  def update
    if @short_link.update(short_link_params)
      redirect_to short_link_url(@short_link), notice: "Short link was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /short_links/1 or /short_links/1.json
  def destroy
    @short_link.destroy!

    redirect_to root_path, notice: "Short link was successfully destroyed."
  end

  def decrease_usages
    if @short_link.usages
      @short_link.usages -= 1
      @short_link.save
    end
    return nil
  end
  helper_method :decrease_usages

  def generate_report
    @report = Report.new()

    @report.short_link_id = @short_link.id
    @report.date = Date.today
    @report.hour = Time.now.localtime
    @report.ip = request.remote_ip
    @report.user_agent = request.user_agent
    @report.save

    return nil
  end
  helper_method :generate_report  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_short_link
      @short_link = ShortLink.find_by(id: params[:id], 'user_id': current_user.id)

      if !@short_link
        render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def short_link_params
      params.require(:short_link).permit(:user_id, :short_url, :url, :expiration_date, :password, :usages)
    end
end
