import Prelude
import Graphics.UI.SDL as SDL

main = do
    SDL.init [InitEverything]
    setVideoMode 640 480 32 []
    screen <- getVideoSurface
    SDL.flip screen

