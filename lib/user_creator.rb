require 'pry'
class UserCreator

  def initialize(number_of_users)

  @number_of_users = number_of_users

  end

  def create_users
    users = []

    for i in 1..@number_of_users
      username = "user_#{i}"
      user = create_user("User #{i}", username, "https://robohash.org/#{username}", get_upload_track_count)
      puts user
      users << user
    end

    users
  end

  def get_upload_track_count
    is_artist = Random.rand(2) == 0 ? false : true
    is_artist ? Random.rand(1..100) : 0
  end

  def create_user(display_name, username, icon_url, upload_track_count)
    following_number = Random.rand(1...@number_of_users-1)
    following_usernames = Array(1..@number_of_users).sample(following_number).map{|i| "user_" + i.to_s }
    following = following_usernames.select{|u| u != username}
    {
      'display_name' => display_name,
      'username' => username,
      'icon_url' => icon_url,
      'upload_track_count' => upload_track_count,
      'following' => following
    }
  end
end
