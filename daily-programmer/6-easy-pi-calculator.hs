{-

    https://www.reddit.com/r/dailyprogrammer/comments/pp53w/2142012_challenge_6_easy/

    [2/14/2012] Challenge #6 [easy]

    You're challenge for today is to create a program that can calculate pi accurately to at least 30 decimal places.

    Try not to cheat :)

-}

import Data.List (unfoldr)
import Data.Function ((&))

main :: IO ()
main = do
    putStrLn $ piDigits 30

piDigits :: Int -> String
piDigits n =
    replicate len 2
    & unfoldr (Just . digit)
    & take n
    & concatMap show
    & tail
    & ("3," ++)
    where len = (10 * n) `div` 3

digit :: [Int] -> (Int, [Int])
digit rems = rems
    & map (*10)
    & zip [0..]
    & foldr calc (0, [])

calc :: (Int, Int) -> (Int, [Int]) -> (Int, [Int])
calc (i, x) (carry, rems) =
    let
        val = x + carry * (i + 1)
        den = if i == 0 then 10 else (2 * i) + 1
        rem = val `mod` den
        quo = val `div` den
    in
        (quo, rem:rems)
