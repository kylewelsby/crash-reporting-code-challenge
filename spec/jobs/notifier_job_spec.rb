require "rails_helper"

RSpec.describe NotifierJob, type: :job do
  let :project do
    Project.create!
  end

  let :stacktrace do
    [
      {
        file: "Crash.java", # Mandatory
        method: "crashyMethod", # Mandatory
        line: 10 # Optional
      },
      {
        file: "Main.java",
        method: "main",
        line: 5
      }
    ]
  end

  let :metadata do
    {
      custom_field: "customValue",
      custom_entity: {
        id: "123",
        description: "Sample metadata"
      }
    }
  end

  it "passes to NotiferService to calculate the validility" do
    expect(NotifierService).to receive(:new)
      .with(project.id, "error", "An error occurred", stacktrace, metadata).and_call_original
    subject.perform(project.id, "error", "An error occurred", stacktrace, metadata)
  end
end
