require "rails_helper"
require 'pry'

RSpec.describe ArtistsController, :type => :controller do

  describe "GET #index for a user following 24 artists" do
    it "responds successfully with an HTTP 200 status code" do
      following_array = (2..25).map { |i|  User.create(:username => "user_" + i.to_s, :upload_track_count => 10)}
      allow(User).to receive(:all_users).and_return([User.create(:username => "user_1", :following => (2..25).map { |i| 'user_'+ i.to_s })] + following_array)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns a valid two array response for any page" do
      get :index, username: 'user_1', page: 3
      expect(JSON.parse(response.body)['first_degree']).not_to be_nil
    end

    it "returns 10 first_degree artists on first page" do
      get :index, username: 'user_1', page: 1
      expect(JSON.parse(response.body)['first_degree'].count).to equal(10)
    end

    it "returns 10 first_degree artists on second page" do
      get :index, username: 'user_1', page: 2
      expect(JSON.parse(response.body)['first_degree'].count).to equal(10)
    end

    it "returns 4 first_degree artists on third page" do
      get :index, username: 'user_1', page: 3
      expect(JSON.parse(response.body)['first_degree'].count).to equal(4)
    end

    it "returns 0 first_degree artists on fourth page" do
      get :index, username: 'user_1', page: 4
      expect(JSON.parse(response.body)['first_degree'].count).to equal(0)
    end
  end
end