require "user_creator"

class BackdoorController < ApplicationController

	def create
		directory = Rails.root.join('tmp/users.json').to_s
		count = (params[:count] || 0).to_i
		count = count < 20 ? 20 : count > 500 ? 500 : count

		creator = UserCreator.new(count)
		users = creator.create_users

		File.open(directory, 'w') do |f|
			f.puts users.to_json
		end

		head :no_content
  end

end