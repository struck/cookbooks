execute "curl install.amon.cx | bash" do
  cwd Chef::Config[:file_cache_path]
end
