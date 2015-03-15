class UsersController < ApplicationController
  def index
	directory = './test/fixtures/users.rb'
	@data = File.exist?(directory) ? File.read("./test/fixtures/users.rb") : '[]'
	render :json => @data
  end
end