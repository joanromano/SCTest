require 'active_hash'

class User < ActiveHash::Base

	field :username
	field :display_name
	field :icon_url
	field :upload_track_count
	field :following

	def User.create_from_dic(user_dictionary)
		create :username => user_dictionary['username'], 
		       :display_name => user_dictionary['username'], 
		       :icon_url => user_dictionary['icon_url'], 
		       :upload_track_count => user_dictionary['upload_track_count'], 
		       :following => user_dictionary['following']
	end

	def is_artist
		self.upload_track_count > 0
	end

	def output_representation
		{
		  'display_name' => self.display_name,
		  'username' => self.username,
		  'icon_url' => self.icon_url,
		  'upload_track_count' => self.upload_track_count,
		}
	end

end