#
# Cookbook Name:: daemonize
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cache_dir = Chef::Config[:file_cache_path]

package "git" do
    action :install
end

package "gcc" do
    action :install
end

package "make" do
    action :install
end

bash "install daemonize" do
    not_if {File.exists?("#{cache_dir}/daemonize")}
    user "root"
    cwd cache_dir
    code <<-EOH
        git clone git://github.com/bmc/daemonize.git
        cd daemonize && sh configure && make && sudo make install
    EOH
end
