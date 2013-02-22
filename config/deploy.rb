# RVM
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3@feedback'
set :rvm_type, :system

after "deploy:update_code", "deploy:symlink_config"

# Bundler
require "bundler/capistrano"
set :bundle_without, [:development, :test, :deployment]

# Assets
load 'deploy/assets'

set :user, "rails"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}"

set :application, "feedback"
set :repository, "git://github.com/fjcb/fruitback.git"

role :web, "feedback.digineo.de" # Your HTTP server, Apache/etc
role :app, "feedback.digineo.de" # This may be the same as your `Web` server
role :db, "feedback.digineo.de", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_config do
    run "ln -fs #{shared_path}/secret_token.rb #{latest_release}/config/initializers/"
  end
  task :reset do
    run "cd #{current_path} && bundle exec rake db:migrate:reset db:seed", env: { RAILS_ENV: 'production' }
  end
  task :init do
    update
    restart
    reset
  end
end
