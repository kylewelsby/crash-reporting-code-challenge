require "rails_helper"

RSpec.describe "Statistics", type: :request do
  before :each do
    # request.headers["accept"] = 'application/json'
  end
  describe "GET /projects/<ID>/stats" do
    let :project do
      Project.create!
    end

    it "returns http success" do
      get "/projects/#{project.id}/stats", headers: {accept: "application/json"}
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include(invalid: 0)
      expect(json).to include(error: 0)
      expect(json).to include(warning: 0)
      expect(json).to include(info: 0)
    end
  end
end
