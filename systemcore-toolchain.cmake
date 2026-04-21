# see github.com/LimelightVision/systemcore-os-public/crosscomp_examples/cpp

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

SET(CMAKE_C_COMPILER_WORKS 1)
SET(CMAKE_CXX_COMPILER_WORKS 1)

set(CROSSCOMP_NAME aarch64-buildroot-linux-gnu)
set(HOST_DIR /opt/systemcore-aarch64-toolchain)

set(CMAKE_FIND_ROOT_PATH ${HOST_DIR}/${CROSSCOMP_NAME})
set(CMAKE_SYSROOT ${HOST_DIR}/${CROSSCOMP_NAME}/sysroot)
# Avoid this path
# set(CMAKE_STAGING_PREFIX /home/test)
# From wpilibsuite/opensdk
# with some additional silencing
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-psabi -Wno-unused-parameter -Wno-stringop-overflow -Wno-array-bounds")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-psabi -Wno-unused-parameter -Wno-stringop-overflow -Wno-array-bounds")

set(CMAKE_C_COMPILER ${HOST_DIR}/bin/${CROSSCOMP_NAME}-gcc)
set(CMAKE_CXX_COMPILER ${HOST_DIR}/bin/${CROSSCOMP_NAME}-g++)

# Search for programs in host directories only
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Search for libraries and headers in the toolchain directories only
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)