# Programming Challenges

This is a repository with solutions to common programming problems.
Each solution exists in its own file.
A problem, which needs to be solved is described in the topmost comment.
This includes link to original excercise page.

## What are the Rules?

- No build system should be used, except for compiler
- There should be only one file per solution
- Only one utility file is allowed per language

## How to launch a solution?

To launch a solution:

For `.hs` files:

    sudo apt install haskell-platform
    runghc 1-easy-input.hs

For `.c` files:

    sudo apt install gcc
    gcc 1-easy-input.c -o bin/1-easy-input && bin/1-easy-input

For `.cpp` files:

    sudo apt install gcc
    g++ 1-hard-guessing-game-reverse.cpp -std=c++17 -o bin/1-hard-guessing-game-reverse && bin/1-hard-guessing-game-reverse

For `.py` files:

    sudo apt install python3
    python3 1-easy-input.py

For `.java` files:

    sudo apt install openjdk-14-jdk
    java ./1-hard-guessing-game-reverse.java
