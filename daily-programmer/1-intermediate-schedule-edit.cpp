/*

    https://www.reddit.com/r/dailyprogrammer/comments/pihtx/intermediate_challenge_1/

    [intermediate] challenge #1

    create a program that will allow you to enter events organizable by hour.
    There must be menu options of some form, and you must be able to easily edit, add, and delete events without directly changing the source code.

    (note that by menu i dont necessarily mean gui.
    as long as you can easily access the different options and receive prompts and instructions telling you how to use the program, it will probably be fine)

*/

#include "utils/utils.hpp"

#include <string>
#include <vector>
#include <functional>

using namespace std;
using namespace utils;

#define UNUSED(x) (void)(x)

struct event {
    int hour;
    std::string name;
};

struct command {
    int argc;
    std::function<std::string(std::vector<event> &events,
                              const std::vector<std::string> &args)> fn;
};

std::string fn_help(std::vector<event> &events,
                    const std::vector<std::string> &args);

std::string fn_list(std::vector<event> &events,
                    const std::vector<std::string> &args);

std::string fn_create(std::vector<event> &events,
                      const std::vector<std::string> &args);

std::string fn_update(std::vector<event> &events,
                      const std::vector<std::string> &args);

std::string fn_delete(std::vector<event> &events,
                      const std::vector<std::string> &args);

std::string fn_exit(std::vector<event> &events,
                    const std::vector<std::string> &args);

vector<string> split(const string &orig,
                     const char sep)
{
    vector<string> res;

    stringstream ss(orig);
    string tok;
    while (getline(ss, tok, sep))
        res.push_back(tok);

    return res;
}

int main()
{
    vector<event> events;

    unordered_map<string, command> commands{
            {"help",   {0, fn_help}},
            {"list",   {0, fn_list}},
            {"create", {2, fn_create}},
            {"update", {1, fn_update}},
            {"delete", {1, fn_delete}},
            {"exit",   {0, fn_exit}}
    };

    while (true) {
        // TODO : Prompt is LOST (!)
        string raw = prompt("> ");
        vector<string> tokens = split(raw, ' ');

        if (tokens.empty())
            continue;

        auto res = commands.find(tokens[0]);
        if (res == commands.end()) {
            cout << "failed to find command '" << tokens[0] << "'" << endl;
            continue;
        }

        if (static_cast<size_t>(res->second.argc + 1) != tokens.size()) {
            cout << "command '" << tokens[0]
                 << "' require " << res->second.argc << " arg(s)" << endl;
            continue;
        }

        cout << res->second.fn(events, tokens) << endl;
    }
}

string fn_help(vector<event> &events,
               const vector<string> &args)
{
    UNUSED(events);
    UNUSED(args);

    ostringstream ss;

    ss << "command list: " << newl
       << tab << "- help             -- output current message" << newl
       << tab << "- list             -- ordered list of all events" << newl
       << tab << "- create HOUR NAME -- add new event" << newl
       << tab << "- update INDEX     -- edit specific event" << newl
       << tab << "- delete INDEX     -- remove specific event" << newl
       << tab << "- exit             -- quit application";

    return ss.str();
}

bool comparator(const event &a,
                const event &b)
{
    return a.hour < b.hour;
}

string fn_list(vector<event> &events,
               const vector<string> &args)
{
    UNUSED(args);

    if (events.empty())
        return "no events added yet";

    ostringstream ss;
    for (size_t i = 0; i < events.size(); i++)
        ss << "[" << i << "]: hour = " << events[i].hour
           << ", name = " << events[i].name;

    return ss.str();
}

string fn_create(vector<event> &events,
                 const vector<string> &args)
{
    auto opt_hour = convert<int>(args[1]);
    if (!opt_hour.has_value())
        return "hour argument must be an int";
    int hour = opt_hour.value();

    if (hour < 0 || hour > 23)
        return "hour argument must be in [0, 23], but was "s + to_string(hour);

    events.push_back({hour, args[2]});
    sort(begin(events), end(events), comparator);
    return "event was successfully added";
}

string fn_update(vector<event> &events,
                 const vector<string> &args)
{
    auto opt_idx = convert<int>(args[1]);
    if (!opt_idx.has_value())
        return "idx argument must be an int";
    int idx = opt_idx.value();

    if (idx < 0)
        return "idx argument must be greater or equal to 0";

    if (static_cast<size_t>(idx) >= events.size())
        return "idx of "s + to_string(idx) + " does not exist";

    event evt = events[idx];

    string hour_str = prompt("input hour ("s + to_string(evt.hour) + ") > ");
    if (!hour_str.empty()) {
        auto opt_hour = convert<int>(args[1]);
        if (!opt_hour.has_value())
            return "hour argument must be an int";
        int hour = opt_hour.value();

        if (hour < 0 || hour > 23)
            return "hour argument must be in [0, 23], but was "s +
                   to_string(hour);

        evt.hour = hour;
    }

    string name = prompt("input name ("s + evt.name + ") > ");
    if (!name.empty())
        evt.name = name;

    events.erase(begin(events) + idx);
    events.push_back(evt);

    sort(begin(events), end(events), comparator);
    return "event was successfully updated";
}

string fn_delete(vector<event> &events,
                 const vector<string> &args)
{
    auto opt_idx = convert<int>(args[1]);
    if (!opt_idx.has_value())
        return "idx argument must be an int";
    int idx = opt_idx.value();

    if (idx < 0)
        return "idx argument must be greater or equal to 0";

    if (static_cast<size_t>(idx) >= events.size())
        return "idx of "s + to_string(idx) + " does not exist";

    events.erase(begin(events) + idx);
    return "event was successfully removed";
}

string fn_exit(vector<event> &events,
               const vector<string> &args)
{
    UNUSED(events);
    UNUSED(args);
    exit(EXIT_SUCCESS);
}
