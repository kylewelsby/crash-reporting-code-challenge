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
    project.invalid.incr if invalid?
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
