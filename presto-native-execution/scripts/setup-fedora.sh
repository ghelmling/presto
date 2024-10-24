#!/bin/bash
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

set -e
set -x

export nproc=$(getconf _NPROCESSORS_ONLN)

CPU_TARGET="${CPU_TARGET:-avx}"
SCRIPT_DIR=$(dirname "${BASH_SOURCE}")
source "${SCRIPT_DIR}/../velox/scripts/setup-fedora.sh"
SUDO="${SUDO:-"sudo --preserve-env"}"

function install_presto_deps_from_package_managers {
  ${SUDO} dnf install -y maven java clang-tools-extra jq perl-XML-XPath
  ${SUDO} dnf install -y gperf  
  # This python version is installed by the Velox setup scripts
  pip install regex pyyaml chevron black
}

function install_proxygen {
  github_checkout facebook/proxygen "${FB_OS_VERSION}"
  cmake_install -DBUILD_TESTS=OFF -DLDFLAGS=-latomic
}

function install_presto_deps {
  run_and_time install_presto_deps_from_package_managers
  run_and_time install_proxygen
}

if [[ $# -ne 0 ]]; then
  # Activate gcc12; enable errors on unset variables afterwards.
  # source /opt/rh/gcc-toolset-12/enable || exit 1
  set -u
  for cmd in "$@"; do
    run_and_time "${cmd}"
  done
  echo "All specified dependencies installed!"
else
  if [ "${INSTALL_PREREQUISITES:-Y}" == "Y" ]; then
    echo "Installing build dependencies"
    run_and_time install_build_prerequisites
  else
    echo "Skipping installation of build dependencies since INSTALL_PREREQUISITES is not set"
  fi
  # Activate gcc12; enable errors on unset variables afterwards.
  # source /opt/rh/gcc-toolset-12/enable || exit 1
  set -u
  install_velox_deps
  install_presto_deps
  echo "All dependencies for Prestissimo installed!"
fi

dnf clean all
