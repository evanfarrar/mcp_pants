set :application, "mcp_pants"
set :domain, "creeperrape.net"
set :deploy_to, "/data/mcp_pants"
set :repository, 'git://github.com/evanfarrar/mcp_pants.git'


remote_task "vlad:bundle:install" do
  run "cd #{deploy_to}/current; bundle install --deployment"
end

remote_task "vlad:minecraft" do
  run "god minecraft restart"
end

task "vlad:deploy" => %w[
    vlad:update vlad:bundle:install vlad:start_app vlad:cleanup
]
