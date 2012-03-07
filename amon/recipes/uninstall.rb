execute "curl uninstall.amon.cx | sh" do
  cwd Chef::Config[:file_cache_path]
  user 'root'
  group 'root'
end
