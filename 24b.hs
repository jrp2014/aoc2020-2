import AOC

main = interact $ f . parselist (many1 enump)

data Dir = E | SE | SW | W | NW | NE deriving (Show, Eq, Read, Ord, Bounded, Enum)

dirToCoord E  = ( 1,  0)
dirToCoord W  = (-1,  0)
dirToCoord NE = ( 1,  1)
dirToCoord NW = ( 0,  1)
dirToCoord SE = ( 0, -1)
dirToCoord SW = (-1, -1)

godir z d = z + dirToCoord d

nbs = map dirToCoord [minBound .. maxBound]
rule x ns = let n = count True ns in n == 2 || x && n == 1

coordsToMap margin zs = [[(x, y) `elem` zs | x <- [minx..maxx]] | y <- [miny..maxy]]
  where
    (minx, miny) = minimum zs - (margin, margin)
    (maxx, maxy) = maximum zs + (margin, margin)

nIters = 100

f xs = sum $ map (count True) $ vtol2 $ applyN nIters (mapnbs nbs rule) $ ltov2 m
  where
    m = coordsToMap nIters $ map head $ filter (odd . length) $ group $ sort $ map (foldl' godir 0) xs
