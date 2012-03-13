
return if node[:firewall] == false

case node[:platform]
when "ubuntu"
  # To see settings for ufw, https://github.com/chef-cookbooks/ufw
  # Generally speaking, however, the struck_core recipes will not
  # set up anything but default firewall settings. Any roles added
  # to the node should add their own firewall settings accordingly.
  require_recipe 'ufw'
else
  raise "Cannot set up firewall on your #{node[:platform]} platform. The Struck Core cookbook does not yet support firewall on this platform. TODO."
end