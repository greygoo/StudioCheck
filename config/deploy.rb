# rvm related info
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2@studio_checker'
set :rvm_type, :user

# bundler
require "bundler/capistrano"

# app settings
set :application, "StudioCheck"
set :repository,  "git@github.com:bkutil/StudioCheck.git"
set :scm, :git
set :deploy_to, "/srv/app/check.kutilovi.cz"
set :use_sudo, false
set :user, "cap"

role :web, "kutilovi.cz"
role :app, "kutilovi.cz"
role :db,  "kutilovi.cz", :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end
