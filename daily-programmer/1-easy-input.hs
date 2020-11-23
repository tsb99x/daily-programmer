{-

    https://www.reddit.com/r/dailyprogrammer/comments/pih8x/easy_challenge_1/

    [easy] challenge #1

    create a program that will ask the users name, age, and reddit username.
    have it tell them the information back, in the format:

    your name is (blank), you are (blank) years old, and your username is (blank)

    for extra credit, have the program log this information in a file to be accessed later.

-}

import System.IO (hFlush, stdout)

main :: IO()
main =
    input >>= formMsg >>= output

input :: IO (String, String, String)
input = do
    name <- prompt "input your name"
    age <- prompt "input your age"
    username <- prompt "input your username"
    return (name, age, username)

formMsg :: (String, String, String) -> IO String
formMsg (name, age, username) =
    return $ concat
        [ "your name is ", name, ", "
        , "you are ", age, " years old, "
        , "and your username is ", username
        , "\n"
        ]

output :: String -> IO ()
output msg = do
    putStr msg
    appendFile "tmp/log.txt" msg

-- UTILS

prompt :: String -> IO String
prompt msg = do
    putStr $ msg ++ " > "
    hFlush stdout
    getLine
