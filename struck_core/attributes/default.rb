#
# Cookbook Name:: struck_core
# Attributes:: default
#
# Copyright 2012, Struck 
#

#
#
# Core Server data
#
#
# The core server identification information. All these attributes
# will be required, but must be filled out on a per-server basis. 
# There is no default value for these attributes.
  # The name assigned to this server. Not to be confused
  # with the full domain name. This name should be word 
  # characters only.
  default[:server][:name] = nil
  # A list of domains that will be hosted on this node. 
  # May include the ip as a domain.
  default[:server][:domains] = ['localhost']

#
#
# The sysadmin and app users, groups, and the sudo lightsabre.
#
#
  # The sysadmin user is the main user that will be performing ongoing
  # actions and ssh logins on this machine. Similar to the old convention
  # of naming primary admin users after the server name itself, this 
  # username should generally be allowed to remain default across multiple
  # platforms, resulting in multiple machines using the same account. This
  # will allow server actions to effectively remain agnostic toward the 
  # server they are running on, though passwords should remain individualized
  # per server.
  default[:authorization][:sysadmin][:id] = 'struck'
  default[:authorization][:sysadmin][:groups] = ['sudo']
  default[:authorization][:sysadmin][:comment] = '** Struck Global Admin User'
  default[:authorization][:sysadmin][:manage_home] = false
  default[:authorization][:sysadmin][:shell] = "\/bin\/bash"
  # The deployer user, which is used for both deploying and running the apps 
  # installed on this machine. (By apps, we mean the databases, web applications, 
  # or other software for which this server is primarily focused. )
  default[:authorization][:deployer][:id] = 'app'
  default[:authorization][:deployer][:groups] = ['sudo']
  default[:authorization][:deployer][:comment] = '** This user runs the applications on this server.'
  default[:authorization][:deployer][:manage_home] = true
  default[:authorization][:deployer][:shell] = "\/bin\/bash"
  # Which groups to add sudo priveleges to. 
  default[:authorization][:sudo][:groups] = ["sudo"]
  default[:authorization][:sudo][:passwordless] = true
  # If true, the "root" user will have ssh rights removed.
  default[:authorization][:disable_root_ssh] = true

#
#
# Firewall rules. 
#
#
  # Defaults to only SSH and Ping
  # See https://github.com/chef-cookbooks/ufw
  # and https://github.com/chef-cookbooks/firewall
  default[:firewall][:enabled] = true
  default[:firewall][:rules] = []

