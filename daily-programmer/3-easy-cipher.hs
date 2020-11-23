{-

    https://www.reddit.com/r/dailyprogrammer/comments/pkw2m/2112012_challenge_3_easy/

    [2/11/2012] Challenge #3 [easy]

    Welcome to cipher day!

    write a program that can encrypt texts with an alphabetical caesar cipher.
    This cipher can ignore numbers, symbols, and whitespace.

    for extra credit, add a "decrypt" function to your program!

-}

import System.IO (hFlush, stdout)
import System.Exit (die)
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

import qualified Data.Map.Strict as Map

main :: IO ()
main =
    input >>= process >>= output

data Mode = Encrypt | Decrypt

input :: IO (Mode, String, Int)
input = do
    mode <- getMode "select [e]ncrypting or [d]ecrypting mode"
    msg <- prompt "message"
    rot <- getInt "rotation shift"
    return (mode, msg, rot)

getMode :: String -> IO Mode
getMode msg = do
    line <- prompt msg
    case line of
        "e" -> return Encrypt
        "d" -> return Decrypt
        _ -> die "only [e] or [d] symbols are allowed"

process :: (Mode, String, Int) -> IO String
process (mode, msg, shift) =
    return $ map (apply $ mapping mode shift) msg

mapping :: Mode -> Int -> Map.Map Char Char
mapping mode shift =
    let
        alphabet = ['a'..'z'] ++ ['A'..'Z']
        realShift = shift `mod` length alphabet
        derived = drop realShift alphabet ++ take realShift alphabet
    in
        Map.fromList $ case mode of
            Encrypt -> zip alphabet derived
            Decrypt -> zip derived alphabet

apply :: Map.Map Char Char -> Char -> Char
apply mapping symbol =
    fromMaybe symbol $ Map.lookup symbol mapping

output :: String -> IO ()
output msg =
    putStrLn $ "result: " ++ msg

-- UTILS

getInt :: String -> IO Int
getInt msg = do
    line <- prompt msg
    case readMaybe line of
        Just x -> return x
        Nothing -> die "only int values are allowed"

prompt :: String -> IO String
prompt msg = do
    putStr $ "input " ++ msg ++ " > "
    hFlush stdout
    getLine
