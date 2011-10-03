data Queen = Queen { col :: Int, lgn :: Int }

queens 0 = [[]]
queens n = [ cur:qs | qs <- queens (n-1), curr <- [1..8], safe curr qs ]
safe q qs = all (check (length qs + 1, q) qs
check (col, ln) (col', ln') = abs q1 - q2
