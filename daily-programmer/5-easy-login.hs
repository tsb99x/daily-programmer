{-

    https://www.reddit.com/r/dailyprogrammer/comments/pnhyn/2122012_challenge_5_easy/

    [2/12/2012] Challenge #5 [easy]

    Your challenge for today is to create a program which is password protected, and wont open unless the correct user and password is given.

    For extra credit, have the user and password in a seperate .txt file.

    for even more extra credit, break into your own program :)

-}

import System.IO (hFlush, stdout)

main :: IO ()
main = output =<< authenticate =<< readCreds
    where output login = putStrLn $ "successfully logged in as " ++ login

readCreds :: IO [(String, String)]
readCreds = map (toCred . words) . lines <$> readFile "res/passwords.txt"

toCred :: [String] -> (String, String)
toCred [login, pass] = (login, pass)
toCred _ = error "passwords file is malformed"

authenticate :: [(String, String)] -> IO String
authenticate creds = do
    login <- prompt "login"
    pass <- prompt "pass"
    if (login, pass) `elem` creds
        then return login
        else do
            putStrLn "wrong login and password combination, try again\n"
            authenticate creds

prompt :: String -> IO String
prompt msg = do
    putStr $ "input " ++ msg ++ " > "
    hFlush stdout
    getLine
