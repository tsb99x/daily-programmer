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
main = output . formMsg =<< input
    where output str = mapM_ ($ str) [putStr, appendFile "tmp/log.txt"]

input :: IO (String, String, String)
input = do
    name <- prompt "your name"
    age <- prompt "your age"
    username <- prompt "your username"
    return (name, age, username)

formMsg :: (String, String, String) -> String
formMsg (name, age, username) =
    concat
        [ "your name is ", name, ", "
        , "you are ", age, " years old, "
        , "and your username is ", username
        , "\n"
        ]

-- UTILS

prompt :: String -> IO String
prompt msg = do
    putStr $ "input " ++ msg ++ " > "
    hFlush stdout
    getLine
