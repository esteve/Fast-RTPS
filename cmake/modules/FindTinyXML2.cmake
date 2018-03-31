# TINYXML2_FOUND
# TINYXML2_INCLUDE_DIR
# TINYXML2_SOURCE_DIR

option(TINYXML2_FROM_SOURCE "Integrate TinyXML2 source code inside Fast RTPS" OFF)

find_package(TinyXML2 CONFIG QUIET)
if(TinyXML2_FOUND)
    message(STATUS "Found TinyXML2: ${TinyXML2_DIR}")
    if(NOT TINYXML2_LIBRARY AND TARGET tinyxml2)
        # in this case, we're probably using TinyXML2 version 5.0.0 or greater
        # in which case tinyxml2 is an exported target and we should use that
        string(TOUPPER ${CMAKE_BUILD_TYPE} tinyxml2_CONFIGURATION)
        get_property(tinyxml2_IMPORTED_CONFIGURATIONS TARGET tinyxml2 PROPERTY IMPORTED_CONFIGURATIONS)
        if(${tinyxml2_CONFIGURATION} IN_LIST tinyxml2_IMPORTED_CONFIGURATIONS)
            message(STATUS "Configuration: ${tinyxml2_CONFIGURATION} found in imported configurations")
        else()
            message(STATUS "Configuration: ${tinyxml2_CONFIGURATION} NOT found in imported configurations, defaulting to RELEASE")
            set(tinyxml2_CONFIGURATION "RELEASE")
        endif()
        
        message("=== TINYXML2_CONFIGURATION ${tinyxml2_CONFIGURATION} ===")
        get_property(tinyxml2_IMPORTED_LOCATION TARGET tinyxml2 PROPERTY IMPORTED_LOCATION_${tinyxml2_CONFIGURATION})
        message("==== IMPORTED_LOCATION ${tinyxml2_IMPORTED_LOCATION} ===")
        set(TINYXML2_LIBRARY ${tinyxml2_IMPORTED_LOCATION})
        message("==== TINYXML2_LIBRARY ${TINYXML2_LIBRARY} ===")
    endif()
else()
    if(THIRDPARTY)
        set(TINYXML2_FROM_SOURCE ON)
    endif()

    if(THIRDPARTY OR ANDROID)
        find_path(TINYXML2_INCLUDE_DIR NAMES tinyxml2.h NO_CMAKE_FIND_ROOT_PATH)
    else()
        find_path(TINYXML2_INCLUDE_DIR NAMES tinyxml2.h)
    endif()


    if(TINYXML2_FROM_SOURCE)
        find_path(TINYXML2_SOURCE_DIR NAMES tinyxml2.cpp NO_CMAKE_FIND_ROOT_PATH)
    else()
        find_library(TINYXML2_LIBRARY tinyxml2)
    endif()

    include(FindPackageHandleStandardArgs)

    if(TINYXML2_FROM_SOURCE)
        find_package_handle_standard_args(tinyxml2 DEFAULT_MSG TINYXML2_SOURCE_DIR TINYXML2_INCLUDE_DIR)

        mark_as_advanced(TINYXML2_INCLUDE_DIR TINYXML2_SOURCE_DIR)
    else()
        find_package_handle_standard_args(tinyxml2 DEFAULT_MSG TINYXML2_LIBRARY TINYXML2_INCLUDE_DIR)

        mark_as_advanced(TINYXML2_INCLUDE_DIR TINYXML2_LIBRARY)
    endif()
endif()
