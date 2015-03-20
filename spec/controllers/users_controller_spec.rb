require "rails_helper"
require 'pry'

RSpec.describe UsersController, :type => :controller do

  let(:username) { FactoryGirl.create :user }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns a valid two array response for a username" do
      get :index, username: 'user_1'
      expect(JSON.parse(response.body).count).to equal(2)
    end

    it "returns a valid two array response for a username and page" do
      get :index, username: 'user_1', page: 2
      expect(JSON.parse(response.body).count).to equal(2)
    end

    it "returns first and second degree artists for a username following artists" do
      get :index, username: 'user_1', page: 1
      expect(JSON.parse(response.body)[0]).not_to be_empty
      expect(JSON.parse(response.body)[1]).not_to be_empty
    end

    it "returns no first group artists for a extremely large page" do
      get :index, username: 'user_1', page: 5000
      expect(JSON.parse(response.body)[0]).to be_empty
    end

    it "returns no artists for an invalid username" do
      get :index, username: 'invalid_invalid_invalid_username', page: 0
      expect(JSON.parse(response.body)[0]).to be_empty
      expect(JSON.parse(response.body)[1]).to be_empty
    end

  end
end