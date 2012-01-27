{-# LANGUAGE OverloadedStrings #-}

import Network.Wai
import Network.Wai.Handler.Warp
import Network.HTTP.Types (status200)
import Blaze.ByteString.Builder (fromByteString)
import qualified Data.ByteString.Char8 as B

main = do
    image <- B.readFile "image.jpeg"
    run 8080 (app image)

app :: B.ByteString -> Application
app image req = do
    return $ ResponseBuilder status200 [
            ("Content-Type", "image/jpeg"),
            ("Content-Length", B.pack $ show $ B.length image)
        ] $ fromByteString image