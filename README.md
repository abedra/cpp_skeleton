# C++ Project Template

Clone this repository to start a new C++ project. It uses [uv](https://docs.astral.sh/uv/) to manage python and [conan](https://conan.io/). Builds are handled using [cmake](https://cmake.org/) with [ninja](https://ninja-build.org/), and tests are built with [Catch2](https://github.com/catchorg/Catch2). A github actions file is added to quickly automate CI.

## Setup

You will need the following dependencies installed:

* gcc 13 or greater
* cmake 3.26 or greater
* ninja
* uv

Complete setup instructions for the latest versions of Ubuntu and Rocky Linux can be found in the docker directory of this project.

```shell
git clone --depth 1 https://github.com/abedra/cpp_skeleton <project_name>
cd <project_name>
make reset_vcs
```

## Installing Dependencies

Dependencies can be added using [Conan](https://conan.io/). To add a dependency,
add the dependency to the `conanfile.txt` file and run the following command:

```shell
# use BUILD_TYPE=release for release builds
BUILD_TYPE=debug make setup
```

## Build

```shell
make build
```

## Test

```shell
# will also run build
make test
```