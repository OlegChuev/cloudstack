#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

#############################################################################################
#
# Clean old multipath maps that have 0 paths available
#
#############################################################################################

SCRIPT_NAME=$(basename "$0")

if [[ $(pgrep -f ${SCRIPT_NAME}) != "$$" ]]; then
        echo "Another instance of ${SCRIPT_NAME} is already running! Exiting"
        exit
fi


cd $(dirname $0)

for WWID in $(multipathd list maps status | awk '{ if ($4 == 0) { print substr($1,2); }}'); do
  ./disconnectVolume.sh ${WWID}
done

exit 0
