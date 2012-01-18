main =
    let sumOfSquares = sum $ map (^2) [1..100]
        squareOfSum = (sum [1..100])^2
    in print $ squareOfSum - sumOfSquares