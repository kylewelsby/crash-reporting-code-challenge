class NotifierJob < ApplicationJob
  queue_as :default

  def perform(project_id, severity, message, stacktrace, metadata)
    NotifierService.new(project_id, severity, message, stacktrace, metadata).call
  end
end
