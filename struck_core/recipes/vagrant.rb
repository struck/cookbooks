#
# Cookbook Name:: struck_core
# Recipe:: vagrant
# Description:: This recipe modifies some attributes for use on a vagrant dev box. A number of the attribute overrides that are carried out in this recipe are based on forced overrides, because many core vagrant properties are not able to be cascaded from chef properties. 
# 
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

def announce(say)
  puts "[#{self.cookbook_name}::#{self.recipe_name}] #{say}"
end

vconfig = node[:vagrant][:config][:keys]

# We must verify that the core sysadmin user is the same user
# used by Vagrant. Since the sysadmin user is generally given 
# exclusive sudo rights, it makes more sense to assume it is the
# same user than to create an additional user.
announce "Overriding sysadmin id with vagrant ssh username: #{vconfig[:ssh][:username]}"
node[:authorization][:sysadmin][:id] = vconfig[:ssh][:username]

# The server name is a required attribute, and defaulting it to 
# the vm box name is an easy way to not require more json attributes
# to need to be declared in the Vagrantfile.
unless node[:server][:name]
  announce "Defaulting node[:server][:name] to vagrant vm box name: #{vconfig[:vm][:box]}"
  node[:server][:name] = vconfig[:vm][:box]
end

# Vagrant has a set of forwarded ports defined. Lets be sure these
# ports are open in the firewall on the vagrant box.
vconfig[:vm][:forwarded_ports].each do |fp|
  current_rule_names = node[:firewall][:rules].collect { |rule| rule.keys }.flatten
  # Unfortunately, the only method we have of comparison is the name. In the chef 
  # firewall recipe, a rule can have any string as a name. Vagrant assigns names more
  # officially, however, using the config.vm.forward_port method, which only takes 
  # guestport and hostport arguments. All in all, if specific firewall rules are set
  # in the attributes, using the same ports but different names than those assigned
  # by Vagrant, there may be redundancy or contradition. This shouldn't be a huge 
  # matter, as the vagrant box is meant for dev, but provisioning could be halted
  # depending on how ufw reacts to certain matches of rules.
  unless current_rule_names.include?(fp[:name])
    announce "Adding Vagrant forwarded port (#{fp[:hostport]} => #{fp[:guestport]}) to node[:firewall][:rules]"
    o = {}
    o[:protocol] = fp[:protocol] if fp.has_key?(:protocol)
    o[:port] = fp[:guestport] if fp.has_key?(:guestport)
    node[:firewall][:rules].push({ fp[:name] => o })
  end
  # {
  #     "adapter": 1, 
  #     "auto": true, 
  #     "guestport": 22, 
  #     "hostport": 2222, 
  #     "name": "ssh", 
  #     "protocol": "tcp"
  # }
end  