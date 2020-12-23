{-

    https://www.reddit.com/r/dailyprogrammer/comments/pnhyn/2122012_challenge_5_easy/

    [2/12/2012] Challenge #5 [easy]

    Your challenge for today is to create a program which is password protected, and wont open unless the correct user and password is given.

    For extra credit, have the user and password in a seperate .txt file.

    for even more extra credit, break into your own program :)

-}

import Utils (input)
import Text.Read (readMaybe)

data Credential = Credential
    { login :: String
    , password :: String
    } deriving (Eq, Read)

main :: IO ()
main = output =<< authenticate =<< readCreds
    where readCreds = map readCred . lines <$> readFile "res/passwords.txt"
          output = putStrLn . ("successfully logged in as " ++)

authenticate :: [Credential] -> IO String
authenticate creds = do
    login <- input "login > "
    pass  <- input "pass > "
    if Credential login pass `elem` creds
        then return login
        else do
            putStrLn "wrong login and password combination, try again\n"
            authenticate creds

-- UTILS

readCred :: String -> Credential
readCred s = case readMaybe s of
    Just x -> x
    Nothing -> error "passwords file is malformed"
