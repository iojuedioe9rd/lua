

-- Define the Lua project
project "lua"
   kind "StaticLib"  -- or "SharedLib" if you prefer a DLL/shared object
   language "C"
   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

   -- Include all C source files and headers in the Lua source directory.
   -- (Assuming you have a directory structure similar to the official Lua distribution.)
   files {
      "*.c",  -- all the core source files (e.g. lapi.c, lcode.c, lctype.c, etc.)
      "*.h"   -- headers for Lua's implementation
   }

   removefiles { "lua.c", "luac.c" } 
   
   -- Define any include directories needed (if Lua’s headers are in src/ you might not need extra ones)
   includedirs { "src" }
   
   -- Set compile options for different configurations
   filter "configurations:Debug"
      defines { "LUA_DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
    filter "configurations:Dist"
      defines { "NDEBUG", "LUA_DIST" }
      optimize "Full"
      flags { "LinkTimeOptimization", "NoRuntimeChecks" }
