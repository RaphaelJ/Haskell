import System.Environment

import Vision.Image
import Vision.Primitive

main = do
    [pathIn, pathOut, strSize] <- getArgs
    i <- load pathIn :: IO RGBImage

    let Size w h = getSize i
    let size = read strSize
    let miniSize = Size size size

    --let cropped = if w > h
    --                 then crop i (Rect ((w - h) `quot` 2) 0 h h)
    --                 else crop i (Rect 0 ((h - w) `quot` 2) w w)

    let mini = resize NearestNeighbor i miniSize

    --let withBorder = fromFunction miniSize (drawBorder mini miniSize) :: RGBImage
    save mini pathOut

    return ()
 -- where
    --drawBorder img (Size w h) p@(Point x y)
    --    | x == 0 || y == 0 || x == (w-1) || y == (h-1) = pix `pixApply` const 0
    --    | x == 1 || y == 1 || x == (w-2) || y == (h-2) = pix `pixApply` brighter
    --    | otherwise = pix
    --  where
    --    pix = getPixel img p
    --    brighter val = fromIntegral $ min 255 $ int val + 50

--int :: Integral a => a -> Int
--int = fromIntegral
