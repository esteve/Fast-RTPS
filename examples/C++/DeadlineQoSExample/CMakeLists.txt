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
project("DeadlineQoSExample")

# Find requirements
if(NOT fastcdr_FOUND)
    find_package(fastcdr REQUIRED)
endif()

if(NOT fastrtps_FOUND)
    find_package(fastrtps REQUIRED)
endif()

find_package(asio QUIET)

if(asio_FOUND)
    message(STATUS "Found Asio")
else()
    find_path(ASIO_INCLUDE_DIR NAMES asio.hpp)
    if(ASIO_INCLUDE_DIR)
        message(STATUS "Found Asio in ${ASIO_INCLUDE_DIR}")
    else()
        message(FATAL_ERROR "Asio not found!")
    endif()
endif()

set(CMAKE_CXX_STANDARD 11)

message(STATUS "Configuring DeadlineQoS example...")
file(GLOB DEADLINEQOS_EXAMPLE_SOURCES "*.cxx")

add_definitions(
  -DBOOST_ASIO_STANDALONE
  -DASIO_STANDALONE
)

include_directories(${ASIO_INCLUDE_DIR})

add_executable(DeadlineQoSExample ${DEADLINEQOS_EXAMPLE_SOURCES})
target_link_libraries(DeadlineQoSExample fastrtps fastcdr)
if(UNIX)
  target_link_libraries(DeadlineQoSExample pthread)
endif()

install(TARGETS DeadlineQoSExample
    RUNTIME DESTINATION examples/C++/DeadlineQoSExample/${BIN_INSTALL_DIR}
    )
