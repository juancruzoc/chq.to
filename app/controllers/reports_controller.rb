class ReportsController < ApplicationController
  def show
    @short_link = ShortLink.find(params[:id])
    @q = Report.ransack(params[:q])
    @reports = @q.result(distinct: true).where(short_link_id: @short_link.id)
  end
end
