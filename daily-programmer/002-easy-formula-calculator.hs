{-

    https://www.reddit.com/r/dailyprogrammer/comments/pjbj8/easy_challenge_2/

    [easy] challenge #2

    Hello, coders!
    An important part of programming is being able to apply your programs,
    so your challenge for today is to create a calculator application that has use in your life.
    It might be an interest calculator, or it might be something that you can use in the classroom.
    For example, if you were in physics class, you might want to make a F = M * A calc.

    EXTRA CREDIT: make the calculator have multiple functions!
    Not only should it be able to calculate F = M * A, but also A = F/M, and M = F/A!

-}

import Data.Char (toLower)
import Text.Read (readMaybe)
import Control.Monad ((<$!>))
import System.IO (hFlush, stdout)

data Var = F | M | A

main :: IO ()
main = output . calculate =<< getVars =<< getMode
    where output = putStrLn . convert

getMode :: IO Var
getMode = readMode . map toLower <$> promptMode
    where promptMode = prompt "mode [f]orce, [m]ass or [a]cceleration"

readMode :: String -> Var
readMode "f" = F
readMode "m" = M
readMode "a" = A
readMode _ = error "use 'f', 'm' or 'a' to select mode"

getVars :: Var -> IO (Var, Float, Var, Float)
getVars F = packParams M A
getVars M = packParams F A
getVars A = packParams F M

packParams :: Var -> Var -> IO (Var, Float, Var, Float)
packParams a b = do
    aVal <- getVar a
    bVal <- getVar b
    return (a, aVal, b, bVal)

getVar :: Var -> IO Float
getVar F = readFloat <$!> prompt "force"
getVar M = readFloat <$!> prompt "mass"
getVar A = readFloat <$!> prompt "acceleration"

calculate :: (Var, Float, Var, Float) -> (Var, Float)
calculate (M, m, A, a) = (F, m * a)
calculate (F, f, A, a) = (M, f / a)
calculate (F, f, M, m) = (A, f / m)

convert :: (Var, Float) -> String
convert (F, f) = "F = " ++ show f
convert (M, m) = "M = " ++ show m
convert (A, a) = "A = " ++ show a

-- UTILS

readFloat :: String -> Float
readFloat str =
    case readMaybe str of
        Just x -> x
        Nothing -> error "only float values are allowed"

prompt :: String -> IO String
prompt msg = do
    putStr $ "input " ++ msg ++ " > "
    hFlush stdout
    getLine
