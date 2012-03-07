# Start the services

# if node[:amon][:install_method] == :auto
#   
#   # Auto mode
#   
#   service "amon" do
#     supports :restart => true, :start => true, :stop => true, :status => true
#     action [ :enable, :restart ]
#   end
#   service "amond" do
#     supports :restart => true, :start => true, :stop => true, :status => true
#     action [ :enable, :restart ]
#   end
#   
#   # Manual mode
#   
#   # TODO
#   
# end
# 












# service "amon" do
#   supports :restart => true, :start => true, :stop => true, :status => true
#   action [ :enable, :start ]
# end
# execute "/etc/init.d/amon start" do
#   # the amon service was not starting with the normal service resource.
#   user 'root'
#   not_if File.exists?("/var/run/amon.pid")
# end

# service "amond" do
#   supports :restart => true, :start => true, :stop => true, :status => true
#   action [ :enable, :start ]
# end
# execute "/etc/init.d/amond start" do
#   # the amond service was not starting with the normal service resource.
#   user 'root'
#   not_if File.exists?("/var/run/amond.pid")
# end







# log("Services") { level :debug }
# 
# service_actions = [:stop]
# service_actions.push(:enable) if node[:amon][:autostart]
# service_actions.push(:start) if node[:amon][:autostart] || node[:amon][:install_method] == :auto
# 
# # Enable start at boot if :autostart is true
# # service 'amon' do
# #   supports :restart => true, :start => true, :stop => true, :status => true
# #   action service_actions
# # end
# # service 'amond' do
# #   supports :restart => true, :start => true, :stop => true, :status => true
# #   action service_actions
# # end
# 
# if service_actions.include?(:stop)
#   execute "/etc/init.d/amon stop" do
#     user 'root'
#     not_if(){ !File.exists?("/var/run/amon.pid") }
#   end
#   execute "/etc/init.d/amond stop" do
#     user 'root'
#     not_if(){ !File.exists?("/var/run/amond.pid") }
#   end
# end
# if service_actions.include?(:enable)
#   service "amon" do
#     supports :restart => true, :start => true, :stop => true, :status => true
#     action [ :enable ]
#   end
#   service "amond" do
#     supports :restart => true, :start => true, :stop => true, :status => true
#     action [ :enable ]
#   end
# end
# if service_actions.include?(:start)
#   execute "/etc/init.d/amon start" do
#     user 'root'
#     not_if(){ File.exists?("/var/run/amon.pid") }
#   end
#   execute "/etc/init.d/amond start" do
#     user 'root'
#     not_if(){ File.exists?("/var/run/amond.pid") }
#   end
# end
# 
