require 'json'

desc "Create user fixtures"

task :create_fixtures => :environment do
	for i in 0..2
		Rake::Task[:create_user].execute(Rake::TaskArguments.new(
			['display_name','username','icon_url','upload_track_count'], ['Joan Romano','joanromano','http://icons.iconarchive.com/icons/mazenl77/I-like-buttons-3a/512/Cute-Ball-Go-icon.png',2]))
	end
end

task :create_user, [:display_name, :username, :icon_url, :upload_track_count] => :environment do |t, args|
	user = {:display_name => args.display_name, :username => args.username, :icon_url => args.icon_url, :upload_track_count => args.upload_track_count}
	directory = "./test/fixtures"
	File.open(File.join(directory, 'file.rb'), 'a') do |f|
  		f.puts user.to_json
  	end
end

