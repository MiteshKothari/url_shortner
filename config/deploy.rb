lock "3.8.2"

set :application, 'codaemon_app'
set :repo_url, 'git@github.com:MiteshKothari/url_shortner.git'

set :deploy_to, '/home/deploy/codaemon_app'

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

 desc 'Restart application'
 task :restart do
   on roles(:app), in: :sequence, wait: 5 do
     execute :touch, release_path.join('tmp/restart.txt')
   end
 end

 after :publishing, 'deploy:restart'
 after :finishing, 'deploy:cleanup'
end 