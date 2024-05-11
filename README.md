C++ template/boirplate

# Deps and tools

- Premake
- Clang format
- Clang Tidy

# Steps

1. Clone
2. (**optional**) dont have premake and dont want install globally ? run `./.premake/getPreMake.(sh|bat)` for download and install Premake in this folder.
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

# How to use and create vendor modules

Check the `premake.lua` file to understand how to import a module, but by default, all modules are being called in the `premake.lua`, so you just need to remove the module you won't use.

If you add another module to your project, I recommend following the same pattern. It's not common, but it helps with organization. Each module within the vendor directory has a `premake.lua` that declares a function to update the main premake file to handle that module (library/module). Currently, this pattern is working for simpler libraries, but it should also work for more complex ones. For example, if you need to define separate compilations.

# Installing vendor modules

Some modules inside the vendor directory come with `get.sh` and `get.bat` scripts used for installation (downloading and extraction). These scripts should be executed from the root project directory since they are not configured to know exactly where to install. Feel free to explore these files to better understand their functionality.
