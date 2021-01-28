class NotifierController < ApplicationController
  def create
    NotifierJob.perform_later(
      crash_params[:project_id], 
      crash_params[:severity], 
      crash_params[:message], 
      crash_params[:stacktrace], 
      crash_params[:metadata]
    )
    render nothing: true, status: :accepted
  end

  private

  def crash_params
    params.permit(:project_id, :severity, :message, stacktrace: [:file, :method, :line], metadata: {})
  end
end
