
include_guard()


function(af_add_qt_shared_library)


	set(optionArgs
	)
    set(oneValueArgs
		SOURCES
		TARGET
		VERSION
	)
    set(multiValueArgs
		LINK_LIBRARIES
	)
    cmake_parse_arguments(ARG "${optionArgs}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

	if(NOT DEFINED ARG_VERSION)
		set(ARG_VERSION 0.0.0)
	endif()


	add_library(${ARG_TARGET} SHARED ${ARG_SOURCES})


	include(AfSetupQt)

	af_setup_qt(
		LINK_LIBRARIES ${ARG_LINK_LIBRARIES}
	)


	include(AfSetupBuildDirectories)

	set_target_properties(${ARG_TARGET} PROPERTIES
		RUNTIME_OUTPUT_DIRECTORY "${AF_BUILD_OUTPUT_BIN_DIR}"
		VERSION ${ARG_VERSION}
	)


	include(AfSetupInstallDirectories)

	install(TARGETS ${ARG_TARGET} DESTINATION "${AF_INSTALL_BIN_DIR}")


endfunction()
