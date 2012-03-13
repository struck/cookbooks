#
# Cookbook Name:: struck_core
# Recipe:: server
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

node[:server][:name].to_s.strip!
# Set up the hostname to default to the server name if not already defined.
node[:server][:hostname] ||= node[:server][:name].gsub(/[_|\-|\s]+/, '-')

node[:server][:domains] = [node[:server][:domains]] unless node[:server][:domains].is_a?(Array)
node[:server][:domains].compact!

# Verify that all required node[:server] attributes are present.
if node[:server][:name].nil? || node[:server][:name].empty? 
  raise "node[:server][:name] must contain a value to proceed."
end
if node[:server][:domains].nil? || node[:server][:domains].empty? 
  raise "node[:server][:domains] must contain a value to proceed."
end
# The server name and hostname may not be any words in this list.
invalid_names = ['localhost']
raise "node[:server][:name] may not be #{node[:server][:name]} " if invalid_names.include?(node[:server][:name])
raise "node[:server][:hostname] may not be #{node[:server][:hostname]} " if invalid_names.include?(node[:server][:hostname])

# Set the server hostname
# Do a double check on the hostname to make sure it is valid.
unless /^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$/i =~ node[:server][:hostname]
  raise "Invalid hostname (node[:server][:hostname]): #{node[:server][:hostname]}"
end
execute 'Set the server hostname' do
  user 'root'
  c =  ""
  c += "PREVHOST=\"$(hostname)\"; "
  c += "hostname #{node[:server][:hostname]}; "
  c += "hostname > /etc/hostname; "
  # TODO: This sed command might cause problems with the hosts file down the road, once
  # it is working on a file that perhaps has more hosts defined in it.
  # c += "sed -i -e 's/${PREVHOST}/#{node[:server][:hostname]}/g' /etc/hosts; "
  command c
end
