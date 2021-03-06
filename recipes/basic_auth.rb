#
# Recipe: basic_auth.rb
#

include_recipe "apache2"

arch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"

# Add the necessary modules to apache

["rewrite","expires","ssl"].each do |mod_name|
  apache_module mod_name 
end
  

# Add the dispatcher site
web_app "dispatcher" do
  server_aliases [node['fqdn'], "localhost"]
  application_name "dispatcher"
  docroot "/data/dispatcher"
  server_name node['hostname']
  if node['apache']['version'] == '2.4'
    template "basic_auth/dispatcher.2.4.conf.erb"
  else
    template "basic_auth/dispatcher.conf.erb"
  end
  landing_page node['dispatcher']['landing_page']
end

# Set up the docroot directory for the dispatcher virtual host
directory "/data/dispatcher" do

  owner node['apache']['user']
  group node['apache']['group']

  mode "0755"
  action :create
  recursive true
end

file "/etc/apache2/htpasswd" do
  action :create_if_missing
  owner 'root'
  group 'root'
  mode '0644'
end

#Set up the dispatcher config
template "#{node['apache']['dir']}/dispatcher.any" do
  source "dispatcher.any.erb"
  mode "0644"
  variables(
    :dispatcherName => "cq-dispatcher",
    :serveStaleOnError => "1",
    :statfileslevel => "1",
    :docroot => "/data/dispatcher"
  )
  action :create_if_missing
end 

directory "#{node['apache']['dir']}/dispatcher" do

  owner "root"
  group "root"

  mode "0755"
  action :create
  recursive true
end

template "#{node['apache']['dir']}/dispatcher/render.any" do
  source "render.any.erb"
  mode "0644"
  variables(
    :renderer_port => "#{node['dispatcher']['renderer']['port']}",
    :renderer_hostname => "#{node['dispatcher']['renderer']['hostname']}"
  )
  action :create_if_missing
end 

# Copy other dispatcher dependency configurations from dispatcher folder to client’s /etc/httpd/dispatcher folder
remote_directory "#{node['apache']['dir']}/dispatcher" do
        source "dispatcher"
        files_owner "root"
        files_group "root"
        files_mode 00644
        owner "root"
        group "root"
        mode 0755
end


# Copy dispatcher module into place
cookbook_file "#{node['apache']['libexec_dir']}/mod_dispatcher.so" do
  owner "root"
  group "root"
  mode "0644"

  if node['apache']['version'] == '2.4'
    case arch
      when "amd64"
        source "dispatcher-apache2.4-4.1.7-x86-64.so"
      when "i386"
        source "dispatcher-apache2.4-4.1.7-i686.so"
    end
  else
    case arch
      when "amd64"
        source "dispatcher-apache2.2-4.1.7-x86-64.so"
      when "i386"
        source "dispatcher-apache2.2-4.1.7-i686.so"
    end
  end
end

# Enable the dispatcher module
apache_module "dispatcher" do
  enable "true"
  conf true
end

# Remove the default web site
apache_site "default" do
  enable false
end
