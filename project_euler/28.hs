sumSpiral size = 
    fst $ sumSpiral' (size `div` 2 + 1)
  where
    sumSpiral' 1 = (1, 1)
    sumSpiral' n = 
        let (s, l) = sumSpiral' (n-1)
            incr = (n-1) * 2
            s' = s + 4 * l + 10 * incr
            l' = l + 4 * incr
        in (s', l')

main = print $ sumSpiral 1001