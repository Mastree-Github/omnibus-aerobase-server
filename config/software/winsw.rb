#
# Copyright 2018 Aerobase
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

name "winsw"
default_version "2.6.2"
license :project_license

version "2.6.2" do
  source md5: "fc9d882f2e606bfdf72e71eef2e2c7c3"
end

version "2.1.2" do
  source md5: "1f41775fcf14aee2085c5fca5cd99d81"
end

source url: "https://github.com/winsw/winsw/releases/download/v#{version}/WinSW.NET4.exe"

relative_path "winsw"

build do
  command "mkdir -p #{install_dir}/embedded/apps/winsw"
  copy "./WinSW.NET4.exe", "#{install_dir}/embedded/apps/winsw/aerobasesw.exe"
end
