#pragma once
#include <immintrin.h>
#include <algorithm>
#include <array>
#include <bit>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <memory>
#include <numeric>
#include <random>
#include <string>
#include <vector>
#include <sys/mman.h>
using Fn = void(*)(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool);
struct Entry { const char* name; Fn fn; };
