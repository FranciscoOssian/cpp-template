@echo off

:: File not tested!

@echo off

rem Download the Premake file using curl
curl -o premake.tar.gz -L https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-windows.zip

rem Extract the Premake files without creating an additional directory
7z x premake.tar.gz -o. -y