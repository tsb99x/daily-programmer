{-

    https://www.reddit.com/r/dailyprogrammer/comments/pp53w/2142012_challenge_6_easy/

    [2/14/2012] Challenge #6 [easy]

    You're challenge for today is to create a program that can calculate pi accurately to at least 30 decimal places.

    Try not to cheat :)

-}

import Data.List (unfoldr)

main :: IO ()
main = putStrLn $ piDigits 30

{- This is an implementation of the Pi Spigot Algorithm -}

piDigits :: Int -> String
piDigits n = putComma . convert . feedDigits $ initialize
    where len = (10 * n) `div` 3
          feedDigits = take n . unfoldr (Just . digit)
          initialize = replicate len 2
          convert = concatMap show
          putComma = ("3," ++) . tail

digit :: [Int] -> (Int, [Int])
digit = weave . index . multiply
    where index = zip [0..]
          multiply = map (*10)
          weave = foldr calc (0, [])

calc :: (Int, Int) -> (Int, [Int]) -> (Int, [Int])
calc (i, x) (carry, rems) = (quo, rem:rems)
    where val = x + carry * (i + 1)
          den = if i == 0 then 10 else (2 * i) + 1
          rem = val `mod` den
          quo = val `div` den
