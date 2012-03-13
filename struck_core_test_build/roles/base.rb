name "base"
description "Base Role. Installs core packages and users. This role should be applied to all new servers."
run_list [

  # Essential package handlers
  # "apt",
  # "build-essential",
  # "git",
  
  # Struck Core
  "struck_core::default",
  # Core server settings 
  "struck_core::server", 
  # Core sysadmin users/groups
  "struck_core::sysadmins", 
  "struck_core::firewall"

  
  # 
  
]


# The core server identification information. All these attributes
# will be required, but must be filled out on a per-server basis. 
# There is no default value for these attributes.
default_attributes :server => {
  # The name assigned to this server. Not to be confused
  # with the full domain name. This name should be word 
  # characters only.
  :name => nil,
  # A list of domains that will be hosted on this node. 
  # May include the ip as a domain.
  :domains => ['localhost']
  # The ip of the server
  # :ip => nil,
},

# The sysadmin users, groups, and the sudo lightsabre.
:authorization => {
  # The user/primary is the main user that will be performing ongoing
  # actions and ssh logins on this machine. Similar to the old convention
  # of naming primary admin users after the server name itself, this 
  # username should generally be allowed to remain default across multiple
  # platforms, resulting in multiple machines using the same account. This
  # will allow server actions to effectively remain agnostic toward the 
  # server they are running on, though passwords should remain individualized
  # per server.
  "sysadmin" => {
    "id" => "struck",
    "ssh_keys" => "ssh-rsa AAAAB3Nz...yhCw== bofh",
    # "groups" => [ "struck", "devopers", "wheel" ],
    "groups" => [ "wheel" ],
    "uid" => 2001,
    "shell" => "\/bin\/bash",
    "comment" => "Struck Global Admin User",
    "openid" => "nerds@struck.com"
  },
  
  # Which groups to add sudo priveleges to. 
  "sudo" => {
    "groups" => [ "wheel" ],
    "passwordless" => true
  },
  
  # If true, the "root" user will have ssh rights removed.
  :disable_root_ssh => true
  
},

# Firewall rules. 
# Defaults to only SSH and Ping
# See https://github.com/chef-cookbooks/ufw
# and https://github.com/chef-cookbooks/firewall
:firewall => {
  :enabled => true,
  :rules => []
}

