# Start the services
# service "amon" do
#   supports :restart => true, :start => true, :stop => true, :status => true
#   action [ :enable, :start ]
# end
execute "/etc/init.d/amon start" do
  # the amon service was not starting with the normal service resource.
  user 'root'
end

service "amond" do
  supports :restart => true, :start => true, :stop => true, :status => true
  action [ :enable, :start ]
end
