#
# Cookbook Name:: struck_core
# Recipe:: rubies
# Description:: This recipe automatically handles installing rubies into rbenv and (TODO) rvm.
# 
#
# Copyright 2012, Struck
#
# All rights reserved - Do Not Redistribute
#

if node[:rbenv]
  package 'curl'
  
  rbenv = node[:rbenv]
  
  (rbenv[:rubies] || []).each do |name|
    rbenv_ruby name
  end
  
  if rbenv[:global]
    execute "rbenv global #{rbenv[:global]}" do
      user 'rbenv'
    end
  end
  
  # (rbenv[:gems] || {}).each_pair do |rubie, gems|
  #   Array(gems).each do |gem|
  #     rbenv_gem gem['name'] do
  #       ruby_version rubie
  #       %w{version action options source}.each do |attr|
  #         send(attr, gem[attr]) if gem[attr]
  #       end
  #     end
  #   end
  # end
  
end

if node[:rvm]
  raise "TODO"
end