#!/bin/bash

# Enter the .premake directory
cd .premake || exit

# Download the Premake file using wget with a specific destination
wget -O premake.tar.gz https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-linux.tar.gz

# Extract the Premake files without creating an additional directory
tar -zxvf premake.tar.gz --strip-components=1

# Return to the original directory
cd - || exit
