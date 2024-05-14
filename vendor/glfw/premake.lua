function useGLFW()
    filter { "system:linux" }
        links { "GL", "glfw" }

    filter { "system:macosx" } -- not tested
        links { "glfw3" }
        linkoptions { "-framework OpenGL" }

    filter { "system:windows" } -- not tested
        links { "glfw3", "opengl32" }
    
    filter {}
end