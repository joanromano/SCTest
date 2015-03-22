class ArtistsController < ApplicationController

  def index
    @users_per_page = 10
    @artists = User.all
    page = get_page((params[:page] || 0).to_i)
    user = User.find_by_username(params[:username])
    if user
      first_degree = user.following_users.select(&:is_artist)
      second_degree = user.following_users.map(&:following_users).flatten.uniq.reject{|u| u.id == user.id}.select(&:is_artist) - first_degree
    else
      first_degree = []
      second_degree = []
    end


    render :json => {:first_degree => paginate(first_degree, page), :second_degree => paginate(second_degree, page)}
  end

  def paginate(users, page)
    users.slice(page * @users_per_page, @users_per_page) || []
  end

  def get_page(page)
    page < 2 ? 0 : page - 1
  end

end
