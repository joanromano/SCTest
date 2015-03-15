require 'json'

desc "Create user fixtures"

task :create_fixtures => :environment do
	directory = './test/fixtures/users.rb'
	users_json = JSON.parse(File.exist?(directory) ? File.read(directory) : '[]')
	for i in 0..2
		Rake::Task[:create_user].execute(Rake::TaskArguments.new(
			['display_name','username','icon_url','upload_track_count', 'users'], ['Joan Romano','joanromano','http://icons.iconarchive.com/icons/mazenl77/I-like-buttons-3a/512/Cute-Ball-Go-icon.png',2,users_json]))
	end
	File.open(directory, 'w') do |f|
  		f.puts users_json.to_json
  	end
end

task :create_user, [:display_name, :username, :icon_url, :upload_track_count, :users] => :environment do |t, args|
	user_json = {
		'display_name' => args.display_name,
		'username' => args.username,
		'icon_url' => args.icon_url,
		'upload_track_count' => args.upload_track_count 
	}
 	args.users << user_json
end

