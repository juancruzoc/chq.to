class ReportController < ApplicationController
  def index
    @q = Report.ransack(params[:q])
    @people = @q.result(distinct: true)
  end
end
