class ReportController < ApplicationController
  def list
      if params[:user_agent].present?
          @reports = Report.where("short_link_id = #{params[:id]}")
          @reports = @reports.where('user_agent like ?', "%#{params[:user_agent]}%")
      end
      render(partial: 'reports', locals: { reports: @reports })
  end
end
