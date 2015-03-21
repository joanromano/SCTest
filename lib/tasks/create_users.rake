desc "Create users task"
require "user_creator"

task :create_users => :environment do
	directory = Rails.root.join('tmp/users.json').to_s

	STDOUT.puts "Number of users to create? (MIN: 20 / MAX: 500)"
	input = STDIN.gets.to_i

	input = input < 20 ? 20 : input > 500 ? 500 : input

	creator = UserCreator.new(input)
	users = creator.create_users

	File.open(directory, 'w') do |f|
  		f.puts users.to_json
	end
end
