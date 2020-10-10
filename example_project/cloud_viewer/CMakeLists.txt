cmake_minimum_required(VERSION 3.0)

project(cloud_viewer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find PCL, with the option to include certain components: io, common, etc.
find_package(PCL 1.11 REQUIRED)

include_directories(
    ${PCL_INCLUDE_DIRS}
    ${PROJECT_SOURCE_DIR}
    ${Boost_INCLUDE_DIR}
)

link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

add_executable (cloud_viewer cloud_viewer.cpp)
target_link_libraries (cloud_viewer ${PCL_LIBRARIES})

