#
# Cookbook Name:: dynamodb-local
# Recipe:: default
#
# Copyright (C) 2014 Timehop
#

package "java-1.7.0-openjdk"

config = node["dynamodb-local"]

user config["user"] do
  comment 'Dynamo DB Local account'
end

directory config["directory"] do
  owner config["user"]
  group config["user"]
  action :create
end

tar_extract config["download_url"] do
  target_dir config["directory"]
  creates "#{config["directory"]}/DynamoDBLocal_lib"
end
