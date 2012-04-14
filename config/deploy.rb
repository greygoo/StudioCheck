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

# restart workers + scheduler after deploy
after "deploy:symlink", "deploy:restart_workers"
# after "deploy:restart_workers", "deploy:restart_scheduler"

##
# Rake helper task.
# http://pastie.org/255489
# http://geminstallthat.wordpress.com/2008/01/27/rake-tasks-through-capistrano/
# http://ananelson.com/said/on/2007/12/30/remote-rake-tasks-with-capistrano/
def run_remote_rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')
  cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")}
    RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
    cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
    run cmd
    set :rakefile, nil if exists?(:rakefile)
end

namespace :deploy do
  task :restart_workers, :roles => :db do
    run_remote_rake "resque:restart_workers"
  end

  task :restart_scheduler, :roles => :db do
    run_remote_rake "resque:restart_scheduler"
  end

  task :start do
  end

  task :stop do
  end

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
