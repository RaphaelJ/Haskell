import Utils (divides)

sunday = 6

daysInMonth 1 year = 31
daysInMonth 2 year
    | 4 `divides` year && (not (100 `divides` year) || 400 `divides` year) = 29
    | otherwise = 28
daysInMonth 3 year = 31
daysInMonth 4 year = 30
daysInMonth 5 year = 31
daysInMonth 6 year = 30
daysInMonth 7 year = 31
daysInMonth 8 year = 31
daysInMonth 9 year = 30
daysInMonth 10 year = 31
daysInMonth 11 year = 30
daysInMonth 12 year = 31

nextDay (day, month, year) =
    if day + 1 > daysInMonth month year
       then if month == 12
               then (1, 1, year + 1)
               else (1, month + 1, year)
       else (day + 1, month, year)

nextWeekDay n = (n + 1) `rem` 7

-- | Lists all sundays since 1 January 1900
sundays =
    go 0 (1, 1, 1900)
  where
    go 6       day@(1, month, year) = day : go 0 (nextDay day)
    go weekDay day                  = go (nextWeekDay weekDay) (nextDay day)
    
main =
    let year (d, m, y) = y
        sundaysYear =  map year $ sundays
        sundaysIn20th = takeWhile (<= 2000) $ dropWhile (< 1901) $ sundaysYear
    in print $ length $ sundaysIn20th