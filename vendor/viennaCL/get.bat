@echo off

:: Navigate to the ViennaCL library directory
cd vendor\viennaCL

:: Download the file using BITSAdmin
bitsadmin /transfer "viennaCL" https://sourceforge.net/projects/viennacl/files/1.7.x/ViennaCL-1.7.1.zip/download viennaCL.zip

:: Extract the contents of the file using 7-Zip
7z x viennaCL.zip -aoa

:: Delete the compressed file
del viennaCL.zip

:: Navigate back to the previous directory
cd ..\..
