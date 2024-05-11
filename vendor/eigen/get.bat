@echo off

:: Navigate to the Eigen library directory
cd vendor\eigen

:: Download the file using BITSAdmin
bitsadmin /transfer "eigen" https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip eigen.zip

:: Extract the contents of the file using 7-Zip
7z x eigen.zip -aoa

:: Delete the compressed file
del eigen.zip

:: Navigate back to the previous directory
cd ..\..
