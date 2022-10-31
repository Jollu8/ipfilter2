# CMake generated Testfile for 
# Source directory: /Users/jolluemil/Desktop/ipfilter2
# Build directory: /Users/jolluemil/Desktop/ipfilter2/cmake-build-debug
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test([=[unit_tests]=] "unit_tests")
set_tests_properties([=[unit_tests]=] PROPERTIES  _BACKTRACE_TRIPLES "/Users/jolluemil/Desktop/ipfilter2/CMakeLists.txt;101;add_test;/Users/jolluemil/Desktop/ipfilter2/CMakeLists.txt;0;")
subdirs("googletest")
