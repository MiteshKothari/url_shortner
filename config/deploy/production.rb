set :stage, :production

server '18.221.135.90', user: 'deploy', roles: %w{web app db}