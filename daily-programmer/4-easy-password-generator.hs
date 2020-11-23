{-

    https://www.reddit.com/r/dailyprogrammer/comments/pm6oj/2122012_challenge_4_easy/

    [2/12/2012] Challenge #4 [easy]

    You're challenge for today is to create a random password generator!

    For extra credit, allow the user to specify the amount of passwords to generate.

    For even more extra credit, allow the user to specify the length of the strings he wants to generate!

-}

import System.Exit (die)
import System.IO (hFlush, stdout)
import Text.Read (readMaybe)
import System.Random (getStdGen, randomRs, StdGen)
import Data.List (unfoldr)

main :: IO ()
main =
    input >>= generate >>= output

input :: IO (Int, Int)
input = do
    count <- getInt "passwords count" mustBePositive
    length <- getInt "length of a password" mustBePositive
    return (count, length)

generate :: (Int, Int) -> IO [String]
generate (count, len) = do
    generator <- getStdGen
    return $ takePasses generator count len

takePasses :: StdGen -> Int -> Int -> [String]
takePasses generator count len =
    let
        symbols = ['_', '@', '-', '+', '=', '$', '#']
        alphaNumeric = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']
        alphabet = alphaNumeric ++ symbols
        sequence = randomRs (0, length alphabet - 1) generator
        chars = map (alphabet !!) sequence
    in
        take count $ chunk len chars

chunk :: Int -> [Char] -> [[Char]]
chunk len =
    unfoldr $ Just . splitAt len

output :: [String] -> IO ()
output =
    mapM_ putStrLn

-- UTILS

getInt :: String -> (Int -> IO Int) -> IO Int
getInt msg validator = do
    line <- prompt msg
    case readMaybe line of
        Just x -> validator x
        Nothing -> die "only int values are allowed"

mustBePositive :: Int -> IO Int
mustBePositive val =
    if val <= 0
        then die "only positive integers allowed"
        else return val

prompt :: String -> IO String
prompt msg = do
    putStr $ "input " ++ msg ++ " > "
    hFlush stdout
    getLine
