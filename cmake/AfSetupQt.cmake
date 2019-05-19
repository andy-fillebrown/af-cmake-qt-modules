
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
	set(qt_link_libraries "")
	foreach(link_library ${ARG_LINK_LIBRARIES})
		# If link_library matches "^Qt.*::.+$" set CMAKE_MATCH_1 to the regex part in parenthesis.
		if(link_library MATCHES "^Qt.*::(.+)$")
			list(APPEND qt_components ${CMAKE_MATCH_1})
			list(APPEND qt_link_libraries Qt5::${CMAKE_MATCH_1})
		endif()
	endforeach()

	find_package(Qt5 REQUIRED COMPONENTS ${qt_components})
	target_link_libraries(${ARG_TARGET} ${qt_link_libraries})
endfunction()
