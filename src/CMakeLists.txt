project(lua_staging)

add_executable(lua_staging lua_staging.cpp)
target_link_libraries(lua_staging ${LUA_LIBRARY})