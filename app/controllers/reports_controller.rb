class ReportsController < ApplicationController
  def show
    @short_link = ShortLink.find(params[:id])
    @q = Report.ransack(params[:q])
    @reports = @q.result(distinct: true)
  end
end
