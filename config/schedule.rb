set :output, "/home/deployer/apps/youtube/shared/log/cron.log"
job_type :script, "'#{path}/script/:task' :output"

every 1.day, :at => '4:30 pm' do
  rake "pull_imports"
end

every :reboot do
  command "dropbox start"
end