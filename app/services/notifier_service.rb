class NotifierService
  def initialize(project_id, severity, message, stacktrace, metadata)
    @project_id = project_id
    @severity = severity
    @message = message
    @stacktrace = stacktrace
    @metadata = metadata
  end

  def call
    # TODO validate 
  end
end