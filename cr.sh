find build -type f ! -name '.gitkeep' -exec rm {} +

./.premake/premake5 --file=premake.lua gmake

cd build

make config=release

cd bin/Release

./$(ls | head -n 1)