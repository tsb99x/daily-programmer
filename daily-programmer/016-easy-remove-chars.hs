{-

    https://www.reddit.com/r/dailyprogrammer/comments/q8aom/2272012_challenge_16_easy/

    [2/27/2012] Challenge #16 [easy]

    Hi folks!
    We are in the midst of discussing how this subreddit will go about but for now how about we just concentrate on challenges!

    Write a function that takes two strings and removes from the first string any character that appears in the second string.
    For instance, if the first string is “Daily Programmer” and the second string is “aeiou ” the result is “DlyPrgrmmr”.
    note: the second string has [space] so the space between "Daily Programmer" is removed

    edit: if anyone has any suggestions for the subreddit, kindly post it in the feedback thread posted a day before.
    It will be easier to assess.
    Thank you.

-}

import Test.HUnit ((~=?), runTestTT, Testable(test))
import Control.Monad (void)

main :: IO ()
main = void . runTestTT $ test
    [ "DlyPrgrmmr" ~=? removeChars "aeiou " "Daily Programmer"
    ]

removeChars :: String -> String -> String
removeChars toDel = filter (`notElem` toDel)
