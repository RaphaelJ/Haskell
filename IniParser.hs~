parse = parseTitle . lines

parseTitle (('[':name):xs) = 
    let (content, next) = parseContent xs
    in (takeWhile (/= ']') name, content) : parseTitle next
parseTitle [] = []

parseContent [] = ([], [])
parseContent xs@(('[':_):_) = ([], xs) -- New Section
parseContent (x:xs) -- New var
    | all (== ' ') x = parseContent xs
    | otherwise =  let (name, (_:value)) = break (== ' ') x
                       value' = takeWhile (/= '"') $ tail $ dropWhile (/= '"') value
                       (next, xs') = parseContent xs
                   in ((name, value'):next, xs')
