# Remote server configuration
server '31.31.78.161', user: 'www-data', roles: %w{app db web}

# The path on the remote server where the application should be deployed
set :deploy_to, '/var/data/preview/babidlo.cz.www'

# Use "production" environment
set :rails_env, 'production'

set :branch, :master