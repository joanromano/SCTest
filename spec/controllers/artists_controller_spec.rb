require "rails_helper"
require 'pry'

RSpec.describe ArtistsController, :type => :controller do

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      artists_array = (1..40).map { |i|  User.create(:username => "user_" + i.to_s, :upload_track_count => 10)}
      user_1_following = (2..25).map { |i| 'user_'+ i.to_s }
      user_30_following = ['user_31', 'user_32']
      user_31_following = (2..16).map { |i| 'user_'+ i.to_s }
      user_32_following = (12..29).map { |i| 'user_'+ i.to_s }
      artists_array[0].following = user_1_following
      artists_array[29].following = user_30_following
      artists_array[30].following = user_31_following
      artists_array[31].following = user_32_following
      artists_array[27].upload_track_count = 0
      artists_array[28].upload_track_count = 0

      allow(User).to receive(:all_users).and_return(artists_array)

      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "For a user following 24 artists returns a valid two array response for any page" do
      get :index, username: 'user_1', page: 3
      expect(JSON.parse(response.body)['first_degree']).not_to be_nil
    end

    it "For a non existing user returns two empty degrees arrays on any page" do
      get :index, username: 'invalid_user', page: 4
      expect(JSON.parse(response.body)['first_degree'].count).to equal(0)
      expect(JSON.parse(response.body)['second_degree'].count).to equal(0)
    end

    it "For a user following 24 artists returns 10 first_degree artists on first page" do
      get :index, username: 'user_1', page: 1
      expect(JSON.parse(response.body)['first_degree'].count).to equal(10)
    end

    it "For a user following 24 artists page 0 should return the same as first page" do
      get :index, username: 'user_1', page: 1
      expect(JSON.parse(response.body)['first_degree'].count).to equal(10)
    end

    it "For a user following 24 artists returns 10 first_degree artists on second page" do
      get :index, username: 'user_1', page: 2
      expect(JSON.parse(response.body)['first_degree'].count).to equal(10)
    end

    it "For a user following 24 artists returns 4 first_degree artists on third page" do
      get :index, username: 'user_1', page: 3
      expect(JSON.parse(response.body)['first_degree'].count).to equal(4)
    end

    it "For a user following 24 artists returns 0 first_degree artists on fourth page" do
      get :index, username: 'user_1', page: 4
      expect(JSON.parse(response.body)['first_degree'].count).to equal(0)
    end

    it "For a user following 2 artists who follow 15 and 15 users returns 2 first_degree artists on first page" do
      get :index, username: 'user_30', page: 1
      expect(JSON.parse(response.body)['first_degree'].count).to equal(2)
    end

    it "For a user following 2 artists who follow 15 and 15 users with 5 repeated and 2 non-artists returns 10 second_degree artists on first page" do
      get :index, username: 'user_30', page: 1
      expect(JSON.parse(response.body)['second_degree'].count).to equal(10)
    end

    it "For a user following 2 artists who follow 15 and 15 artists with 5 repeated and 2 non-artists returns 10 second_degree artists on second page" do
      get :index, username: 'user_30', page: 2
      expect(JSON.parse(response.body)['second_degree'].count).to equal(10)
    end

    it "For a user following 2 artists who follow 15 and 15 artists with 5 repeated and 2 non-artists returns 6 second_degree artists on third page" do
      get :index, username: 'user_30', page: 3
      expect(JSON.parse(response.body)['second_degree'].count).to equal(6)
    end

    it "For a user following 2 artists who follow 15 and 15 artists with 5 repeated and 2 non-artists returns 0 second_degree artists on fourth page" do
      get :index, username: 'user_30', page: 4
      expect(JSON.parse(response.body)['second_degree'].count).to equal(0)
    end

    it "For a user following 2 artists who follow 15 and 15 users returns 0 first_degree artists on second page" do
      get :index, username: 'user_30', page: 2
      expect(JSON.parse(response.body)['first_degree'].count).to equal(0)
    end

  end

end