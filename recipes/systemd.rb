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

template "/lib/systemd/system/dynamodb-local.service" do
  source 'systemd.service.erb'
  
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
  Chef::Provider::Service::Init::Redhat
  action [ :enable, :start ]
end

