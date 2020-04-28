# Config valid only for current version of Capistrano
lock '3.6.1'

# Application name
set :application, 'babidlo_www'

# Repository configuration
set :repo_url, 'git@bitbucket.org:babidlo/babidlo.git'

# Dirs which should not be updated from repository
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/fonts')

# Files which should not be updated from repository
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env.local')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Set Whenever identifier
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# Restart passenger with sudo
set :passenger_restart_with_sudo, true

# Add execute permission to binaries (needed for cron)
before "deploy:finishing", :chmod_bin do
	on roles(:app) do
		execute "chmod 777 #{fetch(:deploy_to)}/current/bin/*"
	end
end