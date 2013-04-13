set :output, "/home/deployer/apps/youtube/shared/log/cron.log"
job_type :script, "'#{path}/script/:task' :output"

every 15.minutes do
  rake "pull_imports"
end