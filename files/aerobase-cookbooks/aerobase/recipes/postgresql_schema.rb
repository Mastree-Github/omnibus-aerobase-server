#
# Copyright:: Copyright (c) 2015.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

install_dir = node['package']['install-dir']
database_name = node['unifiedpush']['unifiedpush-server']['db_database']

account_helper = AccountHelper.new(node)
aerobase_user = account_helper.aerobase_user
aerobase_group = account_helper.aerobase_group
os_helper = OsHelper.new(node)

if os_helper.is_windows?
  tmp_dir = "Temp"
  command = "init-unifiedpush-db"
else
  tmp_dir = "tmp"
  command = "./init-unifiedpush-db.sh"
end 

directory "#{install_dir}/#{tmp_dir}" do
  owner aerobase_user
  group aerobase_group
  mode "0755"
  recursive true
  action :create
end

template "#{install_dir}/#{tmp_dir}/db.properties" do
  source "unifiedpush-server-db-properties.erb"
  owner aerobase_user
  group aerobase_group
  mode "0644"
  variables(node['unifiedpush']['unifiedpush-server'].to_hash)
end

execute "initialize unifiedpush-server database" do
  cwd "#{install_dir}/embedded/apps/unifiedpush-server/initdb/bin"
  command "#{command} --config-path=#{install_dir}/#{tmp_dir}/db.properties"
end
