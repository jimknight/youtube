require "bundler/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "198.211.96.39", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "youtube"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :host_name, "youtube.lavatech.com"

set :scm, "git"
set :repository, "git@github.com:jimknight/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# require "bundler/capistrano"
# load 'deploy/assets'

# server "69.164.212.223", :web, :app, :db, primary: true

# set :application, "youtube"
# set :user, "deployer"
# set :deploy_to, "/home/#{user}/apps/#{application}"
# set :deploy_via, :remote_cache
# set :use_sudo, false

# set :scm, "git"
# set :repository, "git@github.com:jimknight/youtube.git"
# set :branch, "master"

# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true

# after "deploy", "deploy:cleanup" # keep only the last 5 releases

# namespace :deploy do
#   %w[start stop restart].each do |command|
#     desc "#{command} unicorn server"
#     task command, roles: :app, except: {no_release: true} do
#       run "/etc/init.d/unicorn_#{application} #{command}"
#     end
#   end

#   task :setup_config, roles: :app do
#     sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
#     sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
#     run "mkdir -p #{shared_path}/config"
#     put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
#     puts "Now edit the config files in #{shared_path}."
#   end
#   after "deploy:setup", "deploy:setup_config"

#   task :symlink_config, roles: :app do
#     run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#   end
#   after "deploy:finalize_update", "deploy:symlink_config"

#   desc "Make sure local git is in sync with remote."
#   task :check_revision, roles: :web do
#     unless `git rev-parse HEAD` == `git rev-parse origin/master`
#       puts "WARNING: HEAD is not the same as origin/master"
#       puts "Run `git push` to sync changes."
#       exit
#     end
#   end
#   before "deploy", "deploy:check_revision"
# end