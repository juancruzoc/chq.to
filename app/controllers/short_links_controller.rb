class ShortLinksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:access]
  before_action :set_short_link, only: %i[ edit update destroy ]

  # GET /access/1 or /short_links/1.json
  def access
    @short_link = ShortLink.find_by(short_url: params[:short_url])

    if  @short_link.expiration_date and @short_link.expiration_date.to_date <= Date.today
      @message = "The link that you are trying to access has expired."
      render 'unavailable_access', status: :not_found
    else
      if @short_link.usages and @short_link.usages.to_i <= 0
        @message = "The link that you are trying to access has no usages left."
        render 'unavailable_access', status: :forbidden
      else
        if @short_link.password != ""
          render 'password_protected_access'
        else
          @short_link.decrease_usages
          Report.new.generate(@short_link.id, request).save
          render 'access'
        end
      end
    end
  end

  def validate_password

    @short_link = ShortLink.find_by(short_url: params[:short_url])

    if params[:password] == @short_link.password
      
      @short_link.decrease_usages
      Report.new.generate(@short_link.id, request).save
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
    @short_link.user_id = current_user.id

    if @short_link.save
      redirect_to '/', notice: "Short link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /short_links/1 or /short_links/1.json
  def update
    if @short_link.update(short_link_params)
      redirect_to '/', notice: "Short link was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /short_links/1 or /short_links/1.json
  def destroy
    @short_link.destroy!

    redirect_to root_path, notice: "Short link was successfully destroyed."
  end 

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
