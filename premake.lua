workspace "MeuProjeto"
    configurations { "Debug", "Release" }
    location "build"

project "MeuProjeto"
    kind "ConsoleApp"
    language "C++"
    targetdir "build/bin/%{cfg.buildcfg}"
    objdir "build/obj/%{cfg.buildcfg}"

    files { "src/*.cpp", "include/*.hpp" }
    includedirs { "include", "vendor/eigen", "vendor/viennaCL", "vendor/viennaCL/CL" }

    defines { "VIENNACL_WITH_OPENCL" }

    filter "configurations:Debug"
        symbols "On"
        optimize "Off"

    filter "configurations:Release"
        symbols "Off"
        optimize "On"

    filter {}

    links { "OpenCL" }
