dofile "vendor/premake.lua"

workspace "MeuProjeto"
    configurations { "Debug", "Release" }
    location "build"

project "glad"
    kind "StaticLib"
    useGlad()

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
    useImGUI("opengl3", "GLFW")
    useGLFW()
    useBoost('accumulators')

    links { "glad" }
