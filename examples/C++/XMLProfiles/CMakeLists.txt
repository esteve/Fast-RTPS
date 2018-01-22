# Copyright 2016 Proyectos y Sistemas de Mantenimiento SL (eProsima).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.5)
project("XMLProfilesExample")

# Find requirements
if(NOT fastcdr_FOUND)
    find_package(fastcdr REQUIRED)
endif()

if(NOT fastrtps_FOUND)
    find_package(fastrtps REQUIRED)
endif()

set(CMAKE_CXX_STANDARD 11)

message(STATUS "Configuring XMLProfilesExample...")
file(GLOB XMLPROFILESEXAMPLE_SOURCES_CXX "*.cxx")

file(COPY ${PROJECT_SOURCE_DIR}/XMLProfilesExample.xml
    DESTINATION ${PROJECT_BINARY_DIR}
    )

add_executable(XMLProfiles ${XMLPROFILESEXAMPLE_SOURCES_CXX} ${XMLPROFILESEXAMPLE_SOURCES_CPP})
target_link_libraries(XMLProfiles fastrtps fastcdr)
install(TARGETS XMLProfiles
    RUNTIME DESTINATION examples/C++/XMLProfilesExample/${BIN_INSTALL_DIR})
