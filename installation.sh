#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Node.js and npm using apt
install_with_apt() {
  sudo apt-get update
  sudo apt-get install -y nodejs npm
}

# Function to install Node.js and npm using yum
install_with_yum() {
  sudo yum install -y nodejs npm
}

# Function to install Node.js and npm using dnf
install_with_dnf() {
  sudo dnf install -y nodejs npm
}

# Function to install Node.js and npm using pacman
install_with_pacman() {
  sudo pacman -Sy --noconfirm nodejs npm
}

# Detect the package manager
if command_exists apt-get; then
  echo "Detected apt package manager."
  install_with_apt
elif command_exists yum; then
  echo "Detected yum package manager."
  install_with_yum
elif command_exists dnf; then
  echo "Detected dnf package manager."
  install_with_dnf
elif command_exists pacman; then
  echo "Detected pacman package manager."
  install_with_pacman
else
  echo "Error: Unsupported package manager."
  exit 1
fi

# Navigate to your project directory
cd /path/to/your/project

# Run npm install
npm install
