class User < ActiveJSON::Base
  include ActiveModel::Serializers::JSON
  set_root_path "tmp"
  set_filename "users"

	field :username
	field :display_name
	field :icon_url
	field :upload_track_count
	field :following

	def is_artist
		self.upload_track_count > 0
	end

	def as_json(*args)
		{
		  'display_name' => self.display_name,
		  'username' => self.username,
		  'icon_url' => self.icon_url,
		  'upload_track_count' => self.upload_track_count,
		}
	end

	def following_users
		following.map{|n| User.find_by_username(n)}
	end

	def following
		attributes[:following] || []
	end

end
