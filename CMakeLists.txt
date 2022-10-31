cmake_minimum_required(VERSION 3.23)

set(PATCH_VERSION "1" CACHE INTERNAL "Patch version")
set(PROJECT_VERSION 0.0.${PATCH_VERSION})
set(MY_PROJECT_NAME ip_filter)
project(${MY_PROJECT_NAME} VERSION ${PROJECT_VERSION})

option(WITH_GOOGLE_TEST "Whether to build Google test" ON)
configure_file(version.h.in version.h)

add_executable(ip_filter main.cpp)
add_library(version_lib lib.cpp)
add_library(ip_lib ip.cpp ip.h)
add_executable(unit_tests test_version.cpp)

set_target_properties(ip_filter version_lib ip_lib unit_tests PROPERTIES
        CXX_STANDARD 14
        CXX_STANDARD_REQUIRED ON
        )
target_include_directories(version_lib
        PRIVATE "${CMAKE_BINARY_DIR}"
        )
target_include_directories(ip_lib
        PRIVATE "${CMAKE_BINARY_DIR}"
        )

target_link_libraries(ip_filter PRIVATE
        version_lib
        ip_lib
        )
target_include_directories(unit_tests PRIVATE ${GTest_INCLUDE_DIR})
target_link_libraries(unit_tests
        gtest
        gtest_main
        pthread
        version_lib
        ip_lib
        )

if(WITH_GOOGLE_TEST)
    #git submodule add https://github.com/google/googletest.git
    #git submodule update --init --recursive
    add_subdirectory(./googletest EXCLUDE_FROM_ALL)
    add_executable(google_test_version test_version.cpp)

    set_target_properties(google_test_version PROPERTIES
            CXX_STANDARD 17
            CXX_STANDARD_REQUIRED ON
            )

    target_link_libraries(google_test_version
            gtest_main
            gmock
            )
endif()
if (MSVC)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    target_compile_options(ip_filter PRIVATE
            /W4
            )
    target_compile_options(version_lib PRIVATE
            /W4
            )
    target_compile_options(ip_lib PRIVATE
            /W4
            )
    target_compile_options(unit_tests PRIVATE
            /W4
            )
else ()
    target_compile_options(ip_filter PRIVATE
            -Wall -Wextra -pedantic -Werror
            )
    target_compile_options(version_lib PRIVATE
            -Wall -Wextra -pedantic -Werror
            )
    target_compile_options(ip_lib PRIVATE
            -Wall -Wextra -pedantic -Werror
            )
    target_compile_options(unit_tests PRIVATE
            -Wall -Wextra -pedantic -Werror
            )
endif()



install(TARGETS ip_filter RUNTIME DESTINATION bin)

set(CPACK_GENERATOR DEB)

set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(CPACK_PACKAGE_CONTACT zholu008@gmail.com)

include(CPack)

enable_testing()

add_test(unit_tests unit_tests)