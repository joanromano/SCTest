class User

	attr_reader :username
	attr_reader :display_name
	attr_reader :icon_url
	attr_reader :upload_track_count
	attr_reader :following 

	def initialize(user_dictionary)
		@username = user_dictionary['username']
		@display_name = user_dictionary['display_name']
		@icon_url = user_dictionary['icon_url']	
		@upload_track_count = user_dictionary['upload_track_count']
		@following = user_dictionary['following']
  	end

  	def isArtist
		@upload_track_count > 0
	end

end