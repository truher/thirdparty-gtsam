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



## Building

Use .github/workflows/main.yml as a guide, e.g. for linux:

```
sudo apt-get install -y ninja-build build-essential libtbb-dev
./gradlew publish -Pplatform=linux-x86_64
```

The build will publish into $HOME/releases/maven, which can
be served locally for testing, e.g.:

```
$HOME/releases/maven/edu/wpi/first/thirdparty/frc2026/gtsam/gtsam-cpp/4.3a1+573fa1d:
gtsam-cpp-4.3a1+573fa1d-linuxx86-64static.zip
gtsam-cpp-4.3a1+573fa1d-sources.zip
...etc...
```