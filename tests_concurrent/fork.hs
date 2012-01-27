import Control.Concurrent (forkIO)
import Control.Monad (forever)
import qualified Data.ByteString.Char8 as B
import Network (PortID(..), withSocketsDo, listenOn, accept)
import System.IO (hClose)
 
main = withSocketsDo $ do
    sock <- listenOn $ PortNumber 8080
    image <- B.readFile "image.jpeg"
    forever $ do
        (h,_,_) <- accept sock
        forkIO $ sendImage image h

sendImage image h = do
    B.hPut h $ response $ image
    hClose h
 
response image =
        B.pack ("HTTP/1.0 200 OK\r\n\
               \Content-type: image/jpeg\r\n\
               \Content-Length: ")
        `B.append` B.pack (show $ B.length image)
        `B.append` B.pack "\r\n\r\n"
        `B.append` image
        `B.append` B.pack "\r\n"