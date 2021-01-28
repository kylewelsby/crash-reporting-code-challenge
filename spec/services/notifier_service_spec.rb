require "rails_helper"

RSpec.describe NotifierService, type: :model do
  let :project do
    Project.create!
  end

  let :severity do
    "error"
  end

  let :message do
    "hello world"
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

  describe "#call" do
    context "invalid" do
      it "increments the invalid counter when severity is not in list" do
        expect {
          described_class.new(project.id, "debug", message, stacktrace, metadata).call
        }.to change(project.invalid_count, :value).by(1)
      end

      it "increments the invalid message is blank" do
        expect {
          described_class.new(project.id, severity, "", stacktrace, metadata).call
        }.to change(project.invalid_count, :value).by(1)
      end

      it "increments the invalid stacktrace is missing file" do
        expect {
          described_class.new(project.id, severity, message, [{method: "StandardError"}], metadata).call
        }.to change(project.invalid_count, :value).by(1)
      end
    end

    it "increments the error count" do
      expect {
        described_class.new(project.id, "error", message, stacktrace, metadata).call
      }.to change(project.error_count, :value).by(1)
    end

    it "increments the warning count" do
      expect {
        described_class.new(project.id, "warning", message, stacktrace, metadata).call
      }.to change(project.warning_count, :value).by(1)
    end

    it "increments the info count" do
      expect {
        described_class.new(project.id, "info", message, stacktrace, metadata).call
      }.to change(project.info_count, :value).by(1)
    end
  end
end
