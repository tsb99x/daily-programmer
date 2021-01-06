/*

    https://www.reddit.com/r/dailyprogrammer/comments/pih8x/easy_challenge_1/

    [easy] challenge #1

    create a program that will ask the users name, age, and reddit username.
    have it tell them the information back, in the format:

        your name is (blank), you are (blank) years old, and your username is (blank)

    for extra credit, have the program log this information in a file to be accessed later.

*/

#include "utils.hpp"

#include <fstream>

using namespace std;

int main() {
    string name     = input("your name > ");
    string years    = input("your age > ");
    string username = input("your username > ");

    string msg = "your name is " + name + ", "
                 "you are " + years + " years old, "
                 "and your username is " + username;

    fstream log("tmp/log.txt", fstream::app);

    cout << msg << endl;
    log << msg << endl;
}
