C++ template/boirplate

# Deps and tools

- Premake
- Clang format
- Clang Tidy

# Steps

1. Clone
2. (**optional**) dont have premake and dont want install globally ? run `./.premake/getPreMake.(sh|dat)` for download and install Premake in this folder.
3. Premake this project: `./.premake/premake5 --file=premake.lua (vs2013|gmake|...)`, all generetade files will place in `build`, visual studio project, gmake.
4. If you choose gmake:
   1. go to `build`
   2. run `make config=release` or `make config=debug`
   3. go to bin/Release
   4. and run exec file, eg: `./$(ls | head -n 1)`

```bash
cpp-template@machine:~/repos/cpp-template$ tree -L 2
.
├── build
├── cr.sh
├── include
│   └── test.hpp
├── premake.lua
├── README.md
├── src
│   ├── main.cpp
│   └── test.cpp
└── vendor
    ├── eigen
    ├── glad
    ├── glfw
    ├── premake.lua
    └── viennaCL
```
