function useViennaCL()
    externalincludedirs { "vendor/viennaCL", "vendor/viennaCL/CL" }
    defines { "VIENNACL_WITH_OPENCL" }
    links { "OpenCL" }
end