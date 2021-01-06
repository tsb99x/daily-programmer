{-

    https://www.reddit.com/r/dailyprogrammer/comments/pih8x/easy_challenge_1/

    [easy] challenge #1

    create a program that will ask the users name, age, and reddit username.
    have it tell them the information back, in the format:

        your name is (blank), you are (blank) years old, and your username is (blank)

    for extra credit, have the program log this information in a file to be accessed later.

-}

import Text.Printf

import Utils

main :: IO ()
main = getInput >>= output
    where output s = putStr s >> appendFile "tmp/log.txt" s

getInput :: IO String
getInput = formMsg <$> input "your name > "
                   <*> input "your age > "
                   <*> input "your username > "

formMsg :: String -> String -> String -> String
formMsg = printf "your name is %s, \
                 \you are %s years old, \
                 \and your username is %s\n"
