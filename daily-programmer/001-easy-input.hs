{-

    https://www.reddit.com/r/dailyprogrammer/comments/pih8x/easy_challenge_1/

    [easy] challenge #1

    create a program that will ask the users name, age, and reddit username.
    have it tell them the information back, in the format:

        your name is (blank), you are (blank) years old, and your username is (blank)

    for extra credit, have the program log this information in a file to be accessed later.

-}

import Utils (input)

main :: IO ()
main = output . formMsg =<< getInput
    where output str = mapM_ ($ str) [putStr, appendFile "tmp/log.txt"]

getInput :: IO (String, String, String)
getInput = do
    name     <- input "your name > "
    age      <- input "your age > "
    username <- input "your username > "
    return (name, age, username)

formMsg :: (String, String, String) -> String
formMsg (name, age, username) = concat
    [ "your name is ", name, ", "
    , "you are ", age, " years old, "
    , "and your username is ", username
    , "\n"
    ]
