class ReportsController < ApplicationController
  before_action :authenticate_user!

  def show
    @short_link = ShortLink.find(params[:id])
    if @short_link.user_id != current_user.id
      not_found
    else
      @q = Report.ransack(params[:q])
      @reports = @q.result(distinct: true).where(short_link_id: @short_link.id)
    end
  end

end
