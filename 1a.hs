import AOC

main = interact $ f . map read

f (x:xs) = if (2020 - x) `elem` xs then x * (2020 - x) else f xs
