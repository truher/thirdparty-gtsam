if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "" FORCE)
endif()

cmake_minimum_required(VERSION 3.25)
set(CMAKE_OSX_ARCHITECTURES arm64 x86_64)
set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT Embedded)
project(thirdparty-gtsam)

include(FetchContent)

# Fetch Eigen 5.0.0:
# https://gitlab.com/libeigen/eigen/-/commit/549bf8c75b6aae071cde2f28aa48f16ee3ae60b0
set(EIGEN_BUILD_BLAS OFF)
set(EIGEN_BUILD_LAPACK OFF)
set(EIGEN_BUILD_CMAKE_PACKAGE ON)
fetchcontent_declare(
    Eigen3
    GIT_REPOSITORY    https://gitlab.com/libeigen/eigen.git
    GIT_TAG           549bf8c75b6aae071cde2f28aa48f16ee3ae60b0
    SYSTEM # Ignore warnings
    # Make gtsam pick up this Eigen as our system Eigen
    OVERRIDE_FIND_PACKAGE
)

# Fetch GTSAM 4.3a1 + assert fix
# https://github.com/borglab/gtsam/commit/573fa1d6230aef6dc81edc286cf9fc09ab9ce823
set(GTSAM_COMPILE_OPTIONS_PRIVATE_DEBUG CACHE INTERNAL FORCE)
set(GTSAM_COMPILE_OPTIONS_PRIVATE_RELWITHDEBINFO CACHE INTERNAL FORCE)
set(GTSAM_ENABLE_BOOST_SERIALIZATION OFF)
set(GTSAM_USE_BOOST_FEATURES OFF)
# Don't worry about distributing libtbb.
set(GTSAM_WITH_TBB OFF)
# Don't throw a C++ exception that's hard to catch.
set(GTSAM_THROW_CHEIRALITY_EXCEPTION OFF)
# Don't use the "unstable" part of GTSAM
set(GTSAM_BUILD_UNSTABLE OFF)
set(GTSAM_BUILD_PYTHON OFF)
set(GTSAM_BUILD_EXAMPLES_ALWAYS OFF)
set(GTSAM_BUILD_TESTS OFF)
set(BUILD_SHARED_LIBS OFF)
set(GTSAM_USE_SYSTEM_EIGEN ON)
if(CMAKE_CXX_COMPILER_ID STREQUAL GNU)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-use-after-free")
endif()
fetchcontent_declare(
    gtsam
    GIT_REPOSITORY    https://github.com/borglab/gtsam
    GIT_TAG           573fa1d6230aef6dc81edc286cf9fc09ab9ce823
)
fetchcontent_makeavailable(gtsam)
