include_recipe "apache2::service"
#include_recipe "appserver::swap"

# install necessary packages: memcached, apc, geoip-devel
packages = [
  'php-pecl-memcached',
  'php-pecl-apc'
]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

# try to install mongo
bash "install_pecl_mongo" do
  user "root"
  code <<-EOH
    pecl install mongo
    exit 0
  EOH
end

execute "install geoip-devel" do
  command "yum install geoip-devel -y"
  action :run
end

# try to install geoip, pecl may return 1 if already installed
bash "install_pecl_geoip" do
  user "root"
  code <<-EOH
    pecl install geoip
    exit 0
  EOH
end

# configure custom apc.ini
etc_dir = "/etc/php.d"
conf_apc    = "apc.ini"

template "#{etc_dir}/#{conf_apc}" do
  
  owner 'root'
  group 'root'
  mode     '0755'
  source   'apc.ini.erb'
  
  variables(
    :enabled        => (node[:appserver][:apc][:enabled]  rescue '1'),
    :shm_size       => (node[:appserver][:apc][:shm_size] rescue '128M'),
    :gc_ttl         => (node[:appserver][:apc][:gc_ttl]   rescue '900')
  )
  
end

# enable mongo module
bash "enable_mongo_module_for_php" do
  code <<-EOH
    printf 'extension=mongo.so\n' | tee /etc/php.d/mongo.ini
  EOH
end

# enable geoip module
bash "enable_geoip_module_for_php" do
  code <<-EOH
    printf 'extension=geoip.so\n' | tee /etc/php.d/geoip.ini
  EOH
end

# Update GeoIP
#include_recipe "appserver::geoipupdate"

# Restart Apache afterwards
service "apache2" do
  action :restart
end
