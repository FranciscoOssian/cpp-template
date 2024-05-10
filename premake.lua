dofile "vendor/premake.lua"

workspace "MeuProjeto"
    configurations { "Debug", "Release" }
    location "build"

project "MeuProjeto"
    kind "ConsoleApp"
    language "C++"
    targetdir "build/bin/%{cfg.buildcfg}"
    objdir "build/obj/%{cfg.buildcfg}"

    files { "src/*.cpp", "include/*.hpp" }
    includedirs { "include" }
    
    filter "configurations:Debug"
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        symbols "Off"
        optimize "On"

    filter {}

    useEigen()
    useViennaCL()
    useGlad()
    useGLFW()
