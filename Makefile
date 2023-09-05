BUILD_DIR=cmake-build-debug
RELEASE_DIR=cmake-build-release

default: setup

.PHONY: reset_vcs
reset_vcs:
	rm -rf .git
	git init

.PHONY: conan
conan:
	conan install . -if $(BUILD_DIR) --profile=default --build=missing

.PHONY: setup
setup:
	mkdir -p $(BUILD_DIR)
	conan install . -if $(BUILD_DIR) --profile=default --build=missing
	cmake -B$(BUILD_DIR) -H. -DCMAKE_BUILD_TYPE=Debug

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

build:
	cmake --build $(BUILD_DIR) -j
	$(BUILD_DIR)/bin/tests

.PHONY: test
test:
	$(BUILD_DIR)/bin/tests

.PHONY: release
release:
	mkdir -p $(RELEASE_DIR)
	conan install . -if $(RELEASE_DIR) --profile=default --build=missing
	cmake -B$(RELEASE_DIR) -H. -DCMAKE_BUILD_TYPE=Release
	cmake --build $(RELEASE_DIR) -j
	$(RELEASE_DIR)/bin/tests
