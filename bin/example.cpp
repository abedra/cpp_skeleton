#include "logger.h"

int main() {
  Logger::init();
  spdlog::info("Hello, World!");
}
