class UsersController < ApplicationController

  def index
  	directory = 'users.json'
    @users_per_page = 10
  	@data = File.exist?(directory) ? File.read(directory) : '[]'
    @data = JSON.parse(@data)
    page = (params[:page] || 0).to_i
    page = page < 2 ? 0 : page - 1
    first_degree = user_follows(params[:username])
    second_degree = []
    first_degree.each{|username| second_degree.concat(user_follows(username))}
    second_degree = second_degree.uniq

  	render :json => [paginate(first_degree, page), paginate(second_degree, page)]
  end

  def paginate(users, page)
    users.slice(page * @users_per_page, @users_per_page) || []
  end

  # TODO FILTER BY ARTIST

  def user_follows(username)
    user = @data.find_all{|item| item["username"] == username}
    user[0] ? user[0]["following"] : []
  end
end