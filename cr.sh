rm -r build

./.premake/premake5 --file=premake.lua gmake

cd build

make config=release

cd bin/Release

./$(ls | head -n 1)