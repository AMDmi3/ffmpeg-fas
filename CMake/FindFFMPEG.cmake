# This file was found on the openscenegraph forums, at
# http://forum.openscenegraph.org/viewtopic.php?t=1738&start=0&postdays=0&postorder=asc&highlight=
# Many thanks to Robert Osfield and Skylark for writing this.  If either of you ever find this,
# just remember that I owe you one. ;)  -OboeNerd


# Locate ffmpeg 
# This module defines 
# FFMPEG_LIBRARIES 
# FFMPEG_FOUND, if false, do not try to link to ffmpeg 
# FFMPEG_INCLUDE_DIR, where to find the headers 
# 
# $FFMPEG_DIR is an environment variable that would 
# correspond to the ./configure --prefix=$FFMPEG_DIR 
# 
# Created by Robert Osfield. 


IF(NOT FFMPEG_LIBAVFORMAT_FOUND) 

SET(FFMPEG_INCLUDE_SEARCH_DIRS 
	${FFMPEG_ROOT}/include 
	$ENV{FFMPEG_DIR}/include
	~/Library/Frameworks 
	/Library/Frameworks 
	/usr/local/include 
	/usr/include/ 
	/sw/include # Fink 
	/opt/local/include # DarwinPorts 
	/opt/csw/include # Blastwave 
	/opt/include 
	/usr/freeware/include 
)

SET(FFMPEG_LIBRARY_SEARCH_DIRS
	${FFMPEG_ROOT}/lib 
	$ENV{FFMPEG_DIR}/lib 
	~/Library/Frameworks 
	/Library/Frameworks 
	/usr/local/lib 
	/usr/local/lib64 
	/usr/lib 
	/usr/lib64 
	/sw/lib 
	/opt/local/lib 
	/opt/csw/lib 
	/opt/lib 
	/usr/freeware/lib64 
)

# Macro to find header and lib directories 
# example: FFMPEG_FIND(AVFORMAT avformat avformat.h) 
MACRO(FFMPEG_FIND varname shortname headername) 
	# First try to find header directly in include directory 
	FIND_PATH(FFMPEG_${varname}_INCLUDE_DIRS ${headername} ${FFMPEG_INCLUDE_SEARCH_DIRS}) 

	# If not found, try to find it in a subdirectory. Tanguy's build has 
	# avformat.h in include/libavformat, so this catches that case. If that's 
	# standard, perhaps we can keep just this case. 
	IF(NOT FFMPEG_${varname}_INCLUDE_DIRS) 
		FIND_PATH(FFMPEG_${varname}_INCLUDE_DIRS lib${shortname}/${headername} ${FFMPEG_INCLUDE_SEARCH_DIRS}) 
	ENDIF(NOT FFMPEG_${varname}_INCLUDE_DIRS) 

	FIND_LIBRARY(FFMPEG_${varname}_LIBRARIES NAMES ${shortname} PATHS ${FFMPEG_LIBRARY_SEARCH_DIRS}) 

	IF (FFMPEG_${varname}_LIBRARIES) 
		SET(FFMPEG_${varname}_FOUND 1) 
	ENDIF(FFMPEG_${varname}_LIBRARIES) 

ENDMACRO(FFMPEG_FIND) 

SET(FFMPEG_ROOT "$ENV{FFMPEG_DIR}" CACHE PATH "Location of FFMPEG") 

FFMPEG_FIND(LIBAVFORMAT avformat avformat.h) 
FFMPEG_FIND(LIBAVDEVICE avdevice avdevice.h) 
FFMPEG_FIND(LIBAVCODEC avcodec avcodec.h) 
FFMPEG_FIND(LIBAVUTIL avutil avutil.h) 
FFMPEG_FIND(LIBSWSCALE swscale swscale.h) # not sure about the header to look for here. 

ENDIF(NOT FFMPEG_LIBAVFORMAT_FOUND) 

SET(FFMPEG_FOUND "NO") 
# Note we don't check FFMPEG_LIBSWSCALE_FOUND here, it's optional. 
IF (FFMPEG_LIBAVFORMAT_FOUND AND FFMPEG_LIBAVDEVICE_FOUND AND FFMPEG_LIBAVCODEC_FOUND AND FFMPEG_LIBAVUTIL_FOUND) 

SET(FFMPEG_FOUND "YES") 

SET(FFMPEG_INCLUDE_DIRS ${FFMPEG_LIBAVFORMAT_INCLUDE_DIRS}) 

SET(FFMPEG_LIBRARY_DIRS ${FFMPEG_LIBAVFORMAT_LIBRARY_DIRS}) 

# Note we don't add FFMPEG_LIBSWSCALE_LIBRARIES here, it will be added if found later. 
SET(FFMPEG_LIBRARIES 
${FFMPEG_LIBAVFORMAT_LIBRARIES} 
${FFMPEG_LIBAVDEVICE_LIBRARIES} 
${FFMPEG_LIBAVCODEC_LIBRARIES} 
${FFMPEG_LIBAVUTIL_LIBRARIES}) 

ELSE (FFMPEG_LIBAVFORMAT_FOUND AND FFMPEG_LIBAVDEVICE_FOUND AND FFMPEG_LIBAVCODEC_FOUND AND FFMPEG_LIBAVUTIL_FOUND) 

MESSAGE(STATUS "Could not find FFMPEG") 

ENDIF(FFMPEG_LIBAVFORMAT_FOUND AND FFMPEG_LIBAVDEVICE_FOUND AND FFMPEG_LIBAVCODEC_FOUND AND FFMPEG_LIBAVUTIL_FOUND) 



#Locate msinttypes
IF(MSVC)
SET(MSINTTYPES_FOUND "NO")
FIND_PATH(MSINTTYPES_INCLUDE_DIR inttypes.h ${FFMPEG_INCLUDE_SEARCH_DIRS})
IF(MSINTTYPES_INCLUDE_DIR)
SET(MSINTTYPES_FOUND "YES")
ENDIF(MSINTTYPES_INCLUDE_DIR)
ENDIF(MSVC)
