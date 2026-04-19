# Third party gtsam
Third party gradle packaging for gtsam

## Updating thirdparty library version

Eigen and GTSAM are pulled in via Cmake using fetch content. To update either, change the SHA or tag in [CMakeLists.txt](CMakeLists.txt). Eigen is required to be pulled in like this to avoid conflicts with wpimath.

## 2025 Build

Use .github/workflows/main.yml as a guide, e.g. for linux:

```
sudo apt-get install -y ninja-build build-essential libtbb-dev
./gradlew publish -Pplatform=linux-x86_64
```

This will run:

* cmakeConfigureDebug
* cmakeBuildDebug

This works fine with the tags (commit from 2025):

```
    Eigen3
    GIT_REPOSITORY    https://gitlab.com/libeigen/eigen.git
    GIT_TAG           0fb2ed140d4fc0108553ecfb25f2d7fc1a9319a1

    gtsam
    GIT_REPOSITORY    https://github.com/borglab/gtsam
    GIT_TAG           42cc0ac922460d506a7bbf3a37a4a0b1e103b79e
```

## New Build

For the new build, use the same Eigen tag as wpimath, which uses
the Eigen 5.0.0 release.

https://gitlab.com/libeigen/eigen/-/commit/549bf8c75b6aae071cde2f28aa48f16ee3ae60b0


```
    Eigen3
    GIT_REPOSITORY    https://gitlab.com/libeigen/eigen.git
    GIT_TAG           549bf8c75b6aae071cde2f28aa48f16ee3ae60b0

```

I'd like to use the 4.3a1 GTSAM release (2f3e56c0ddbd3a1aa54ed043643b553d26a069f6), but it 
fails due to the use of "assert" in SL4.cpp.

This is fixed here

https://github.com/borglab/gtsam/commit/573fa1d6230aef6dc81edc286cf9fc09ab9ce823


```
    gtsam
    GIT_REPOSITORY    https://github.com/borglab/gtsam
    GIT_TAG           573fa1d6230aef6dc81edc286cf9fc09ab9ce823

```

Then run the build:

```
./gradlew publish -Pplatform=linux-x86_64
```

This build succeeds.

The binary artifacts end up in `~/releases/maven`, so they can
be served locally for testing.