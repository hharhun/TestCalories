#!/usr/bin/env bash
source $(dirname $0)/Scripts/Prepare_system.sh
source $(dirname $0)/Scripts/Xcodegen.sh

# Locate script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

Preparesystem

generate_project

sh PodReinstall.command