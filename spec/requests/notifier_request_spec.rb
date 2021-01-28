require "rails_helper"

RSpec.describe "Notifiers", type: :request do
  describe "POST /create" do
    it "returns http success" do
      post "/notify"
      expect(response).to have_http_status(:accepted)
    end
  end
end
