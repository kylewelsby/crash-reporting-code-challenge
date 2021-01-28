class StatisticsController < ApplicationController
  def index
    @project = Project.find_by_id(params[:id])
  end
end
