require "rails_helper"

RSpec.describe "Notifiers", type: :request do
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

  describe "POST /create" do
    it "returns http accepted" do
      expect(NotifierJob).to receive(:perform_later)
        .with("1234", "error", "An error occurred", any_args)
        .and_call_original
      post "/notify", params: {
        project_id: "1234",
        severity: "error",
        message: "An error occurred",
        stacktrace: stacktrace,
        metadata: metadata
      }
      expect(response).to have_http_status(:accepted)
    end
  end
end
