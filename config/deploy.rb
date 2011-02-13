require 'httparty'
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

remote_task "vlad:symlink_stuff" do
  run "ln -s #{deploy_to}/shared/minecraft #{deploy_to}/current/tmp/server"
  run "ln -s #{deploy_to}/shared/maps #{deploy_to}/current/public/images/maps"
  run "chmod -R 777 #{deploy_to}"
end

remote_task "vlad:announce" do
  `curl --data-urlencode "command=say the web client has been updated." http://127.0.0.1:4567`
end

task "vlad:deploy" => %w[
    vlad:actually_update
    vlad:update 
    vlad:bundle:install
    vlad:migrate
    vlad:symlink_stuff
    vlad:start_app vlad:cleanup
    vlad:announce
]


