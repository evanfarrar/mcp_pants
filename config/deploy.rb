set :application, "mcp_pants"
set :domain, "creeperrape.net"
set :deploy_to, "/data/mcp_pants"
set :repository, 'git://github.com/evanfarrar/mcp_pants.git'
set :revision, "master"


remote_task "vlad:bundle:install" do
  run "cd #{deploy_to}/current; bundle install --deployment"
end

remote_task "vlad:minecraft" do
  run "god minecraft restart"
end


remote_task "vlad:actually_update" do
  run "cd #{deploy_to}/scm/repo; git pull"
end

remote_task "vlad:symlink_minecraft" do
  run "ln -s #{deploy_to}/shared/minecraft #{deploy_to}/current/tmp/server"
end

task "vlad:deploy" => %w[
    vlad:update 
    vlad:actually_update
    vlad:bundle:install
    vlad:migrate
    vlad:symlink_minecraft
    vlad:start_app vlad:cleanup
]
