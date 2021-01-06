#pragma once

#include <iostream>

std::string input(
    const std::string& prompt
) {
    std::string res;
    std::cout << prompt << std::flush;
    std::cin >> res;
    return res;
}
