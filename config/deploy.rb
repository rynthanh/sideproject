# config valid only for current version of Capistrano
# lock '3.4.1'

set :application, 'vieterp'
set :repo_url, 'git@github.com:vieterp/hashmicro-10.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:application)}/web/#{fetch(:application)}_production"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

set :ssh_options, {
    forward_agent: false
}

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

    task :reload_odoo do
        on roles(:web), in: :groups, limit: 3, wait: 10 do
            stage = fetch(:stage)
            cmds = [
                "sudo /etc/init.d/odoo restart"
            ]
            execute cmds.join(" && ")
        end
    end

    after :publishing, :reload_odoo

end

