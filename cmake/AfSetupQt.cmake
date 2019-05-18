
include_guard()


function(af_setup_qt)
	set(optionArgs
	)
    set(oneValueArgs
		TARGET
	)
    set(multiValueArgs
		LINK_LIBRARIES
	)
    cmake_parse_arguments(ARG "${optionArgs}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

	# Generate list of Qt components from LINK_LIBRARIES argument.
	set(qt_components "")
	foreach(link_library ${ARG_LINK_LIBRARIES})
		# If link_library matches "^Qt.*::.+$" set CMAKE_MATCH_1 to the part of the regex in parenthesis.
		if(link_library MATCHES "^Qt.*::(.+)$")
			list(APPEND qt_components ${CMAKE_MATCH_1})
		endif()
	endforeach()

	# Find Qt package and components.
	if(WIN32)
		file(GLOB qt5_dir_candidates "C:/Qt/*/*/lib/cmake/Qt5/Qt5Config.cmake")
		# Set Qt5_DIR to the last candidate in the list for now.
		# TODO: Add cache options for selecting Qt5 version and compiler type.
		list(LENGTH qt5_dir_candidates qt5_dir_candidates_length)
		math(EXPR last_qt5_dir_candidates_index "${qt5_dir_candidates_length} - 1")
		list(GET qt5_dir_candidates ${last_qt5_dir_candidates_index} last_qt5_dir_candidate)
		get_filename_component(Qt5_DIR "${last_qt5_dir_candidate}" DIRECTORY)
	else()
		message(FATAL "Finding Qt on platforms other then `WIN32` is not implemented yet")
	endif()
	find_package(Qt5 REQUIRED COMPONENTS ${qt_components})
endfunction()
