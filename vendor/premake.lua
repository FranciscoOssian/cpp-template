dofile "vendor/eigen/premake.lua"
dofile "vendor/viennaCL/premake.lua"
dofile "vendor/glad/premake.lua"
dofile "vendor/glfw/premake.lua"
dofile "vendor/boost/premake.lua"

function useImGUI(...)
    local targets = {...}
    for _, target in ipairs(targets) do
        files {
            "vendor/imgui/*.cpp",
            "vendor/imgui/*.h",
            "vendor/imgui/backends/imgui_impl_" .. target .. "*",
        }
    end

    externalincludedirs { "vendor/imgui", "vendor/imgui/backends" }
end