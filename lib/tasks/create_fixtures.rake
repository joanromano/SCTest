desc "Create user fixtures"

task :create_fixtures => :environment do
	# require 'pry'
	require "user_creator"

	directory = 'users.json'
	creator = UserCreator.new(200)
	users = creator.create_users

	File.open(directory, 'w') do |f|
  	f.puts users.to_json
	end
end
