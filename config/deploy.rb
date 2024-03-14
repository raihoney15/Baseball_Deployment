# config valid for current version and patch releases of Capistrano
server '3.83.16.74', user: 'ubuntu', roles: %w{web app db}

lock "~> 3.18.1"
set :application, "Baseball"
set :repo_url, 'git@github.com:raihoney15/Baseball.git' # Edit this to match your repository
set :branch, :main
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"
set :pty, true
# set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
set :deploy_via, :remote_cache
set :stage, :production
set :rvm_ruby_version, 'ruby-3.0.0' # Edit this if you are using MRI Ruby
set :use_sudo , true
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{release_path}/log/puma_error.log"
set :puma_error_log, "#{release_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true
set :puma_start_cmd, -> { "#{fetch(:rack_env)} bundle exec puma -C #{fetch(:puma_conf)}" }
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :rails_env, 'production'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
namespace :webpacker do
  desc 'Compile webpack assets'
  task :compile do
    on roles(:web) do
      within release_path do
        execute :bundle, :exec, 'rails', 'webpacker:compile', "RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end
end


namespace :deploy do
    desc "Make sure local git is in sync with remote."
    task :check_revision do
      on roles(:app) do
        unless `git rev-parse HEAD` == `git rev-parse origin/main`
          puts "WARNING: HEAD is not the same as origin/main"
          puts "Run `git push` to sync changes."
          exit
        end
      end
    end
   
    desc 'Initial Deploy'
    task :initial do
      on roles(:app) do
        before 'deploy:restart', 'puma:start'
        invoke 'deploy'
      end
    end
   
    desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        invoke 'puma:restart'
      end
    end
    before :starting,     :check_revision
    after  :finishing,    :compile_assets
    after  :finishing,    :cleanup
    after  :finishing,    :restart
  end
   
  # ps aux | grep puma    # Get puma pid
  # kill -s SIGUSR2 pid   # Restart puma
  # kill -s SIGTERM pid   # Stop puma
  set :log_level, :debug


