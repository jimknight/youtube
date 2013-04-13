set :output, "#{path}/log/cron.log"
job_type :script, "'#{path}/script/:task' :output"

every 15.minutes do
  rake "pull_imports"
end