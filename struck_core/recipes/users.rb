#
# Cookbook Name:: struck_core
# Recipe:: sysadmins
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

# Create sysadmin users.
# This sysadmin user is the main user that will be performing ongoing
# actions and ssh logins on this machine. Similar to the old convention
# of naming primary admin users after the server name itself, this 
# username should generally be allowed to remain default across multiple
# platforms, resulting in multiple machines using the same account. This
# will allow server actions to effectively remain agnostic toward the 
# server they are running on, though passwords should remain individualized
# per server.
# 
# In the case of a web server, it is in this user's home folder in which 
# the website files live. (Though /var/www should always use a symblink to
# any live website, and should be used as the global address for the website.)
# 
sysadmin = node[:authorization][:sysadmin]
deployer = node[:authorization][:deployer]

# Required for passwords on ubuntu
# package 'libshadow-ruby1.8'

for u in [sysadmin, deployer] do

  user u[:id] do
    # All values should have default values based on role default attributes.
    username u[:id]
    comment u[:comment]
    shell u[:shell]

    # Groups
    gid "users"

    # Home dir
    unless u[:home] == false
      home "/home/#{u[:id]}" 
      supports({ :manage_home => true })
    end

    # password
    # password "$1$94BGQVwZ$6Gq21xBKCnyBbRU4sTOwE0"
    # TODO: WTF, password not working even though libshadow-ruby is installed.
  end
  
  # Create all groups listed by the sysadmin data.# Automatically add groups to this user if they weren't specified in the group list
  unless u[:autogroups] == false
    u[:groups].push(u[:id]).uniq!
  end

  for sysgroup in u[:groups] do
    group sysgroup do
      members [u[:id]]
      # Appends these members to this group.
      # TODO: is this the correct way to go about it? 
      # what if a server is reprovisioned? and an old
      # user needs to be removed? meh
      # If append is false, and you have several users
      # in the sudo group, only the last user will be 
      # in the group after provisioning. 
      append true
    end 
  end
  
  # action :manage
end

# Run the sudo recipe, which automatically handles sudo rights.
# require_recipe 'sudo'

# Root SSH Access
node[:authorization][:disable_root_ssh] = true if node[:authorization][:disable_root_ssh].nil?
if node[:authorization][:disable_root_ssh]
  execute "Disable root SSH access" do
    command "sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config; /etc/init.d/ssh reload;"
  end
else
  execute "Enable root SSH access" do
    command "sed -i -e 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config; /etc/init.d/ssh reload;"
  end
end


