import AOC

main = interact $ f . rights . map (parse p)

type Bag = Int

p :: Parser (Bag, [(Int, Bag)])
p = do
  b <- bag
  string " contain "
  bs <- (string "no other bags" >> return []) <|> (bags `sepBy1` string ", ")
  char '.'
  return (b, bs)

bag :: Parser Bag
bag = do
  d1 <- many1 letter
  char ' '
  d2 <- many1 letter
  string " bag"
  optional $ char 's'
  return $ hash $ d1 ++ ' ':d2

bags :: Parser (Int, Bag)
bags = do
  n <- read <$> many1 digit
  char ' '
  b <- bag
  return (n, b)

converge :: Eq a => (a -> a) -> a -> a
converge f x = let x' = f x in if x' == x then x else converge f x'

f bs = length (converge containedByAny [hash "shiny gold"]) - 1
  where
    containedByAny bs' = nub $ sort $ bs' ++ map fst (filter (matchAny bs') bs)
    matchAny xs (_, ys) = not $ null [undefined | x <- xs, (_, y) <- ys, x == y]
