-- | Compress all the videos in a directory so that none exceeds the maximum
-- resolution or the maximum bitrate.

import Control.Applicative
import Control.Arrow
import Control.Monad
import Data.Function
import Data.List
import Data.Ratio
import Data.Word
import System.Directory
import System.Environment
import System.Exit
import System.FilePath
import System.IO
import Text.Printf

import System.Process (runProcess, readProcessWithExitCode, waitForProcess)
import Text.Regex.Posix ((=~))

-- | The maximum resolution of the videos in pixels.
maxW, maxH :: Integer
(maxW, maxH) = (1280, 720)

-- | The maximum bitrate of the videos in kbps.
bitrate :: Integer
bitrate = 4 * 1024

-- | The margin in which the bitrate of a video can exceed the maximum bitrate.
tolerance :: Rational
tolerance = 1 % 4 -- 25% of the maximum bitrate

-- | Sets the default language for the audio track.
audioLang :: String
audioLang = "fra"

-- | The path to the ffmpeg executable.
exec :: FilePath
exec = "/usr/bin/ffmpeg"

-- | Valids extensions.
exts :: [String]
exts = [".mkv", ".avi", ".ogv", ".webm", ".mp4"]

main :: IO ()
main = do
    [dir] <- getArgs
    files <- getFiles dir

    sizes <- forM files $ \f -> do
        let path = dir </> f

        (res@(w, h), br) <- getInfos path
        if w > maxW || h > maxH || br > maxBitrate
            then do
                printf "Compressing %s ...\n" path

                let (w', h') = newRes res
                    br' = min bitrate br
                    new = replaceExtension path ".new.mkv"

                code <- encode path new (w', h') br'
                case code of
                    ExitSuccess -> do
                        putStrLn "Encoding successful."

                        size <- filesize path
                        newSize <- filesize new
                        if newSize < size
                            then do
                                let saved = size - newSize
                                printf "%d MiB saved.\n" (saved `div` 1024^2)
                                removeFile path
                                renameFile new path
                                return saved
                            else do
                                removeFile new
                                putStrLn "The new file doesn't save space."
                                return 0
                    _ -> do
                        putStrLn "Fail to encode the file."
                        return 0
            else do
                printf "Don't need to compress %s.\n" path
                return 0

    printf "Total saved space: %d MiB.\n" (sum sizes `div` 1024^2)

  where
    getFiles dir = do
        files <- map (dir </>) <$> getDirectoryContents dir
        let valids = filter ((`elem` exts) . takeExtension) files
        withSize <- forM valids $ \path -> do
            size <- filesize path
            return (path, size)
        return $ reverse $ map fst $ sortBy (compare `on` snd) withSize

    getInfos :: FilePath -> IO ((Integer, Integer), Integer)
    getInfos path = do
        (_, _, out) <- readProcessWithExitCode exec ["-i", path] ""
        putStrLn out

        let (_, _, _, [w, h]) = out =~ "Video: .* ([0-9]*)x([0-9]*)" :: (String, String, String, [String])
            (_, _, _, [bitrate]) = out =~ "bitrate: ([0-9]*) kb/s" :: (String, String, String, [String])

        return ((read w, read h), read bitrate)

    maxBitrate = round $ (bitrate % 1) * (1 + tolerance)

    newRes :: (Integer, Integer) -> (Integer, Integer)
    newRes (w, h) =
        let maxRatio = max (w % maxW) (h % maxH)
            (w', h') = (round $ (w % 1) / maxRatio, round $ (h % 1) / maxRatio)
        in (w' `mod` 2 + w', h' `mod` 2 + h') -- Resolution must be even

    encode path outPath res bitrate = do
        let args = [
                  "-i", path, "-threads", "auto", "-s"
                , printf "%dx%d" (fst res) (snd res), "-vcodec", "libx264"
                , "-b:v", printf "%dk" bitrate, "-acodec", "libvorbis", "-b:a"
                , "448k", "-ac", "2", "-map", "0:0", "-map", "0:1"
                , "-benchmark", "-y", outPath
                ]
        printf "%s %s\n" exec (unwords args)
        pid <- runProcess exec args Nothing Nothing Nothing Nothing Nothing
        code <- waitForProcess pid
        return code

    filesize path = withFile path ReadMode hFileSize
