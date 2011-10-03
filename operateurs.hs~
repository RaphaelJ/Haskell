type Data      = Double -- Mio
type Telephone = Double -- Minutes
type SMS       = Double

data Offer = Offer {
      ofName            :: String
    , ofPrice           :: Double
    , ofCredit          :: Double
    , ofDatePrice       :: Double -- Prix€/Mio
    , ofTelPrice        :: Double -- Prix€/min
    , ofSMSPrice        :: Double -- Prix€/SMS
    , ofData            :: Data
    , ofTel             :: Telephone
    , ofSMS             :: SMS
--    , ofOptions       :: [Option]
    , ofDataReport      :: Bool
    , ofTelReport       :: Bool
    , ofSMSReport       :: Bool
    , ofValidity        :: Int -- Jours de validité (sauf crédit)
    , ofCreditValidity  :: Int
    } deriving (Show)
    
-- data Option = Option {
--       optNom        :: String
--     , optPrix       :: Double
--     , opt
--     }
    
offers = [
    Offer {
          ofName            = "Viking Mobile Full option Classic"
        , ofPrice           = 15
        , ofCredit          = 15
        , ofDataPrice       = 0.5
        , ofTelPrice        = 0.24
        , ofSMSPrice        = 0.10
        , ofData            = 2048
        , ofTel             = 0
        , ofSMS             = 1000
        --, ofOptions         = []
        , ofDataReport      = False
        , ofTelReport       = False
        , ofSMSReport       = False
        , oValidity         = 30
        , oCreditValidity   = floor $ 365 / 2
    }
]

-- | Donne le prix moyen de l'offre par jour sur une année
-- Mio/Jour min/Jour SMS/Jour
offerPrice :: Offer -> Data -> Telephone -> SMS -> Double

offerPrice offer dta tel sms =
    offerPrice' (ofData offer) (ofTel offer) (ofSMS offer) (ofCredit offer) 0
    where offerPrice' dataRest telRest smsRest creditRest day =
            | bonusExpired dataRest telRest smsRest =
                -- Les bonus ne sont plus valables ce jour
                offerPrice' 0 0 0 creditRest day
            | creditExpired creditRest 
            minPrix
            | isJust minPrix && fromJust minPrix < 0 =
                Nothing -- Prix plus petit déjà trouvé
            | otherwise = case consoJour restData restTel restSms restCredit of
                Left (dta, tel, sms, credit)  -> -- Plus de crédit
                    if acheter dta tel sms credit offre
                    then prixOffer
                Right (dta, tel, sms, credit) -> -- Utilisation avec forfait
                    prixOffer' dta tel sms, credit jour+1 minPrix
          
          offerPrice' _ _ _ _ 366 = 0

          enoughData =

          bonusExpired 0 0 0 _          = False --Déjà expiré
          bonusExpired _ _ _ day
              | day >= ofValidity offer = True
              | otherwise               = False
              
          creditExpired dta tel sms credit =
          

          conso restData restTel restSms restCredit ai
          
          -- | Retourne le nombre de crédits restants après le jour (Right)
          -- ou les crédits manquants (Left)
          consoJour restData restTel restSms restCredit =
              let -- Utilisations hors forfait
                  creditData = max 0 $ dtaJour - restData;
                  creditTel  = max 0 $ telJour - restTel;
                  creditSms  = max 0 $ smsJour - restSms;
                  -- Crédit nécéssaire pour les utilisations hors forfait
                  creditNess = creditData * ofPrixData offre
                             + creditTel * ofPrixTel offre
                             + creditSms * ofPrixSms offre;
                  -- Restes dans le forfait
                  restData' = max 0 $ restData - dtaJour;
                  restTel'  = max 0 $ restTel - telJour;
                  restSms'  = max 0 $ restSms' - smsJour;
                  restCredit' = restCredit - creditNess
              in if creditNess > restCredit
                 then Left (creditData, creditTel, creditSms, creditNess)
                 else Right (restData', restTel', restSms', restCredit')
           
           -- | Retourne True si l'achat (aXXX) permet de subvenir à certains
           -- besoins (bXXX)
           acheter bData bTel bSms bCredit offre = 
               | bData > 0 && ofData offre > 0      = True
               | bTel > 0 && ofTel offre > 0        = True
               | bSms > 0 && ofSms offre  > 0       = True
               | bCredit > 0 && ofCredit offre  > 0 = True
               | otherwise                          = False
          
          -- | Consommations journalières
          (dtaJour, telJour, smsJour) = (dta / 365, tel / 365, sms / 365)