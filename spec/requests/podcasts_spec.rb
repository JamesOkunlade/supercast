# spec/controllers/podcasts_controller_spec.rb
require 'rails_helper'

RSpec.describe PodcastsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  # ... other specs
end
