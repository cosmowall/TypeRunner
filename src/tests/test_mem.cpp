#include <gtest/gtest.h>
#include <vector>
#include <fmt/ranges.h>
#include "../core.h"
#include "../checker/compiler.h"
using namespace tr;

TEST(mem, unint) {
    std::vector<unsigned char> bin;

    vm::writeUint32(bin, 0, 1025);
    EXPECT_EQ(bin.size(), 4);

    vm::writeUint32(bin, 4, 1026);
    EXPECT_EQ(bin.size(), 8);

    EXPECT_EQ(vm::readUint32(bin, 0), 1025);
    EXPECT_EQ(vm::readUint32(bin, 4), 1026);

    fmt::print("bin {}\n", bin);
}
