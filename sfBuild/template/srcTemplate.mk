################################################################################
# Created by Eclipse CDT
# Modified by Marc Wren - www.soul-fresh.com
# 
# This file compiles source files from the specified source folder into the object files
# used by the parent make files. For each source folder in your project:
# 1. Duplicate this file, naming it src*.mk (replacing the * with a name of your choosing)
# 2. Find and Replace the string "TEMPLATE" with a name that describes the source folder you are adding.
# 3. Update the first variable (???_SRC_DIR) to point to the location of your source directory (either a relative
#     or absolute path).
# 4. If your source folder is a shared library but not part of the openframeworks addons, uncomment the line
#     #INCLUDE_DIRS += -I"${TEMPLATE_SRC_DIR}"
# 5. Modify any other properties below if necessary as described. 
# 
# Be sure to keep this file in the same directory as the parent makefile so it can be automatically found, 
# or update the parent makefile to include this file explicitly.
################################################################################

# Define the name of the directory you want to include sources from (relative to the location
# of the parent makefile(?).
TEMPLATE_SRC_DIR = path/to/your/source/code

# Add this folder to the list of include directories.
#INCLUDE_DIRS += -I"${TEMPLATE_SRC_DIR}"

# Define the directory into which object files will be placed. You shouldn't need to change this
# unless you want to place the object files somewhere other than the location defaulted to
# by this script. The default is to create a folder next to your sources folder and with the same name 
# but with "_obj" appended to the directory name (ex. if your sources folder is named src, the 
# objects will be placed in a folder called src_obj).
TEMPLATE_OBJ_BASE_DIR := ${TEMPLATE_SRC_DIR}/${shell basename ${TEMPLATE_SRC_DIR}}_obj

# Put objects into separate folders based on the build configuration (usually Debug or Release).
# Only modify this if you do not want to put output from different build configurations in different
# folders.
TEMPLATE_OBJ_DIR = ${TEMPLATE_OBJ_BASE_DIR}/${BUILD_CONFIGURATION_NAME}

# Get a list of all .cpp files in the source folder. Only modify this if you want to exclude some files.
TEMPLATE_SRCS = $(shell find ${TEMPLATE_SRC_DIR} -name "*.cpp")

# Create .d and .o file names from all CPP_SRCS files. Only modify this if you want to exclude some files.
TEMPLATE_OBJS = $(shell echo ${TEMPLATE_SRCS} | sed s:${TEMPLATE_SRC_DIR}:${TEMPLATE_OBJ_DIR}:g | sed s:.cpp:.o:g )

# Add the objects created by this source folder to the list of objects to compile into the output executable.
OBJS += ${TEMPLATE_OBJS}

# Add the objects output folder for this source folder to the list of object folder. Only modify this if you
# do not want the objects to be cleaned when the parent makefile clean target is called.
OBJS_BASE_DIRS += ${TEMPLATE_OBJ_BASE_DIR}
OBJS_DIRS += ${TEMPLATE_OBJ_DIR}

# The defines (ie. -D) flags and any other compiler flags specific to this source folder.
# In most cases you will want to append the global defines and compilation flags but this is not required.
TEMPLATE_SRC_DEFINES = ${DEFINES}
TEMPLATE_SRC_COMPILE_FLAGS = ${COMPILE_FLAGS}

# The rules for building the object files from your source files. If you want to exclude files in the 
# directory, you will need to rewrite this rule as it currently defaults to including all source files.
${TEMPLATE_OBJ_DIR}/%.o: ${TEMPLATE_SRC_DIR}/%.cpp
	@echo 'Building file: $<'
	@echo '------------------------------'
	${MKDIR} ${TEMPLATE_OBJ_DIR}
	${CC} ${TEMPLATE_SRC_DEFINES} ${INCLUDE_DIRS} ${TEMPLATE_SRC_COMPILE_FLAGS} -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo '------------------------------'
	@echo 'Finished building: $<'
	@echo ' '


