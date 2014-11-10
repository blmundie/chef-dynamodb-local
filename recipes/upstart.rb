#
# Cookbook Name:: dynamodb-local
# Recipe:: upstart
#
# Copyright (C) 2014 Timehop
#

config = node["dynamodb-local"]

directory config["log_dir"] do
  owner config["user"]
  group config["user"]
  action :create
end

template "/etc/init/dynamodb-local.conf" do
  source 'upstart.conf.erb'
  
  owner config["user"]
  group config["user"]
  mode 0644

  action :create
  notifies :restart, "service[#{config["name"]}]", :delayed

  variables({
    :name => config["name"],
    :user => config["user"],
    :group => config["user"],
    :log_dir => config["log_dir"],
    :port => config["port"],
    :path => config["directory"]
  })
end

service "dynamodb-local" do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end

