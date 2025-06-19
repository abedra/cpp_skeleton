# C++ Project Template

Clone this repository to start a new C++ project.

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
