#!/usr/bin/env bash

function generate_project {
    # Check xcodegen is installed
    if hash xcodegen 2>/dev/null;
    then
        echo "xcodegen is installed"
    else    
        echo "xcodegen is not installed, run setup.sh"
    fi

    mkdir_touch Modules/Resources/Sources/R.generated.swift

    xcodegen generate
}

# Make directories for SwiftGen results
function mkdir_touch {
    mkdir -p "$(dirname "$1")"
    command touch "$1"
}