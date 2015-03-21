require 'user'
require 'pry'
class ArtistsController < ApplicationController

  def index
    directory = Rails.root.join('tmp/users.json').to_s
    @users_per_page = 10
    @artists = File.exist?(directory) ? File.read(directory) : '[]'
    @artists = JSON.parse(@artists).map {|dictionary|  User.create_from_dic(dictionary)}
    page = get_page((params[:page] || 0).to_i)
    username_param = params[:username]

    first_degree = user_follows(username_param).map{|u| User.find_by_username u}.select{|u| u.is_artist}
    second_degree = user_follows_second_degree(username_param).map{|u| User.find_by_username u}.select{|u| u.is_artist}
    # binding.pry
    second_degree = second_degree - first_degree

    first_degree = first_degree.map{|u| u.output_representation}
    second_degree = second_degree.map{|u| u.output_representation}

    render :json => {:first_degree => paginate(first_degree, page), :second_degree => paginate(second_degree, page)}
  end

  def paginate(users, page)
    users.slice(page * @users_per_page, @users_per_page) || []
  end

  def get_page(page)
    page < 2 ? 0 : page - 1
  end

  def user_follows(username)
    user = User.find_by_username username
    user ? user.following : []
  end

  def user_follows_second_degree(username)
    second_degree = []
    following = user_follows(username)
    second_degree = following.map{|following_username| user_follows(following_username)}.flatten
    second_degree.select{|following_username| following_username != username}.uniq
  end

end