#pragma once

#include <spdlog/spdlog.h>

namespace Logger {
inline void init() {
  spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%f] [thread %t] [%^%l%$] %v");
}
} // namespace Logger
