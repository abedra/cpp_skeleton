SHELL := /bin/bash

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable '$*' is not set"; \
		exit 1; \
	fi

.PHONY: bootstrap
bootstrap: guard-NAME
	rm -rf .git
	sed -i 's/project(cpp_skeleton)/project($(NAME))/' CMakeLists.txt

.PHONY: setup
setup: guard-BUILD_TYPE
	uv sync
	uv run conan profile detect || true
	uv run conan install . --output-folder=build --build=missing --profile:host=conan_$(BUILD_TYPE) --profile:build=conan_$(BUILD_TYPE)
	cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=$(shell echo $(BUILD_TYPE) | sed 's/^./\U&/') -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_COMPILER=/usr/bin/g++-13 -DCMAKE_C_COMPILER=/usr/bin/gcc-13

.PHONY: build
build:
	cmake --build build -j $(( $(nproc) - 2 ))

.PHONY: test
test: build
	./build/tests/tests

.PHONY: clean
clean:
	rm -rf .venv build

.PHONY: docker-ubuntu
docker-ubuntu:
	docker build . -t cpp_skeleton_ubuntu -f docker/ubuntu/Dockerfile

.PHONY:
docker-rocky:
	docker build . -t cpp_skeleton_rocky -f docker/rocky/Dockerfile

.PHONY: intel
intel:
	ln -sf conan_debug_intel conan_debug
	ln -sf conan_release_intel conan_release

.PHONY: apple
apple:
	ln -sf conan_debug_apple conan_debug
	ln -sf conan_release_apple conan_release