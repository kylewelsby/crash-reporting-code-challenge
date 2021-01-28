class NotifierService
  attr_reader :project, :severity, :message, :stacktrace, :metadata
  def initialize(project_id, severity, message, stacktrace, metadata)
    @project_id = project_id
    @severity = severity
    @message = message
    @stacktrace = stacktrace
    @metadata = metadata
  end

  def call
    @project = Project.find_by_id(@project_id)
    if invalid?
      project.invalid_count.incr
    else
      project.error_count.incr if severity == 'error'
      project.warning_count.incr if severity == 'warning'
      project.info_count.incr if severity == 'info'
    end
  end

  def invalid?
    !valid_severity? || !valid_message? || !valid_stacktrace?
  end

  def valid_severity?
    ["error", "warning", "info"].include?(severity)
  end

  def valid_message?
    message.present?
  end

  def valid_stacktrace?
    stacktrace.all? do |trace|
      trace.key?(:file) && trace.key?(:method)
    end
  end
end
