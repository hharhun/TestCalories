#!/usr/bin/env bash

function prepare_system {
    install_xcodegen
}

# === Internal functions ===

# Install Homebrew if needed
function install_homebrew {
    if hash brew 2>/dev/null; 
    then
        echo "Homebrew is installed"
    else
        echo "Homebrew is NOT installed, repair:"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

# Install xcodegen if needed
function install_xcodegen {
    if hash xcodegen 2>/dev/null;
    then
        echo "xcodegen is installed"
    else
        echo "xcodegen is NOT installed, repair:"
        install_homebrew

        echo "brew install xcodegen"
        brew install xcodegen
    fi
}
