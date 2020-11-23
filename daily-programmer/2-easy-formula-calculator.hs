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
import System.Exit (die)
import System.IO (hFlush, stdout)

data Var = F | M | A

main :: IO ()
main =
    getMode >>= getVars >>= calculate >>= output

getMode :: IO Var
getMode = do
    mode <- prompt "select mode [f]orce, [m]ass or [a]cceleration"
    mapMode (map toLower mode)

mapMode :: String -> IO Var
mapMode "f" = return F
mapMode "m" = return M
mapMode "a" = return A
mapMode _ = die "use 'f', 'm' or 'a' to select mode"

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
getVar F = getFloat "input force"
getVar M = getFloat "input mass"
getVar A = getFloat "input acceleration"

calculate :: (Var, Float, Var, Float) -> IO (Var, Float)
calculate (M, m, A, a) = return (F, m * a)
calculate (F, f, A, a) = return (M, f / a)
calculate (F, f, M, m) = return (A, f / m)

output :: (Var, Float) -> IO ()
output (F, f) = putStrLn $ "F = " ++ show f
output (M, m) = putStrLn $ "M = " ++ show m
output (A, a) = putStrLn $ "A = " ++ show a

-- UTILS

getFloat :: String -> IO Float
getFloat msg = do
    line <- prompt msg
    case readMaybe line of
        Just x -> return x
        Nothing -> die "only float values are allowed"

prompt :: String -> IO String
prompt msg = do
    putStr $ msg ++ " > "
    hFlush stdout
    getLine
