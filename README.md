# Third party gtsam
Third party gradle packaging for gtsam

## Updating thirdparty library version

Eigen and GTSAM are pulled in via Cmake using fetch content. To update either, change the SHA or tag in [CMakeLists.txt](CMakeLists.txt). Eigen is required to be pulled in like this to avoid conflicts with wpimath.

## GTSAM version 4.3a1+573fa1d

As of April 2026, the most-recent GTSAM development release is
[4.3a1](https://github.com/borglab/gtsam/commit/2f3e56c0ddbd3a1aa54ed043643b553d26a069f6),
but it fails to build, due to the use of "assert" in SL4.cpp.

This assert was 
[removed](https://github.com/borglab/gtsam/commit/573fa1d6230aef6dc81edc286cf9fc09ab9ce823)
immediately after the 4.3a1 tag,
so the GTSAM "fetchcontent" stanza is:

```
    gtsam
    GIT_REPOSITORY    https://github.com/borglab/gtsam
    GIT_TAG           573fa1d6230aef6dc81edc286cf9fc09ab9ce823
```

And the published version in build.gradle is

```
def pubVersion = "4.3a1+573fa1d"
```

## Eigen version 5.0.0

As of April 2026, wpimath uses the
[Eigen 5.0.0 release](https://gitlab.com/libeigen/eigen/-/commit/549bf8c75b6aae071cde2f28aa48f16ee3ae60b0), so the Eigen "fetchcontent" stanza is:

```
    Eigen3
    GIT_REPOSITORY    https://gitlab.com/libeigen/eigen.git
    GIT_TAG           549bf8c75b6aae071cde2f28aa48f16ee3ae60b0
```

## Using TBB

I don't want to deal with TBB, so I made sure it was not installed on my
build machine, and added 

```cmake
set(GTSAM_WITH_TBB OFF)
```

to the CMakeLists.txt file.

## Cheirality Exception

By default, GTSAM will throw a C++ exception in cases where a camera transform
is attempted with the target "behind" the camera.  I don't want to deal with that,
so I turned off the exception.

```cmake
set(GTSAM_THROW_CHEIRALITY_EXCEPTION OFF)
```

## Unstable

We don't need anything from the "unstable" part of the GTSAM build, so just
turn it off:

```cmake
set(GTSAM_BUILD_UNSTABLE OFF)
```

## Gradle and JDK version

Because the GTSAM wrapper uses java 25, I upgraded the gradle here to 9.4.1,
by typing this (twice, so the gradle jar is updated):

```
./gradlew wrapper --gradle-version 9.4.1
```

Once gradle is updated, you can update the JDK version in the wpilib tree,
e.g.

```
mv jdk jdk17
ln -sfn /usr/lib/jvm/java-25-openjdk-amd64 jdk
```

## Building

Make sure the build tools are installed:

```
sudo apt-get install -y ninja-build build-essential
```

For example:

```
./gradlew publish -Pplatform=linux-x86_64
```

The build will publish into $HOME/releases/maven, which can
be served locally for testing, e.g.:

```
$HOME/releases/maven/release/edu/wpi/first/thirdparty/frc2026/gtsam/gtsam-cpp/4.3a1+573fa1d:
gtsam-cpp-4.3a1+573fa1d-linuxx86-64static.zip
gtsam-cpp-4.3a1+573fa1d-sources.zip
...etc...
```