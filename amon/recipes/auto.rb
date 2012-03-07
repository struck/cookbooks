
log "File cache path: #{Chef::Config[:file_cache_path]}"

execute "curl install.amon.cx | bash" do
  cwd Chef::Config[:file_cache_path]
  user 'root'
  group 'root'
end
