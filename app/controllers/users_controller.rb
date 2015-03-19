require 'User'
require 'pry'
class UsersController < ApplicationController

  def index
	directory = 'users.json'
	@users_per_page = 10
	@data = File.exist?(directory) ? File.read(directory) : '[]'
	@data = JSON.parse(@data).map {|dictionary|  User.new(dictionary)}
	page = get_page((params[:page] || 0).to_i)
	username_param = params[:username]

	first_degree = user_follows(username_param).map{|following_username| find_user(following_username)}.select{|user| user && user.isArtist}
	second_degree = user_follows_second_degree(username_param).map{|following_username| find_user(following_username)}.select{|user| user && user.isArtist}

	render :json => [paginate(first_degree, page), paginate(second_degree, page)]
  end

  def paginate(users, page)
	users.slice(page * @users_per_page, @users_per_page) || []
  end

  def get_page(page)
  	page < 2 ? 0 : page - 1
  end

  def find_user(username)
  	data = @data.select{|user| user.username == username}
  	data[0] ? data[0] : nil
  end

  def user_follows(username)
	user = find_user(username)
	user ? user.following : []
  end

  def user_follows_second_degree(username)
  	second_degree = []
  	following = user_follows(username)
  	second_degree = following.each{|username| second_degree.concat(user_follows(username))}
  	second_degree.uniq
  end

end