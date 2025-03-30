{-# LANGUAGE OverloadedStrings #-}
module AdaWallet where

import qualified Cardano.Api as Api
import qualified Cardano.Crypto.DSIGN.Ed25519 as Ed25519
import qualified Data.ByteString as BS
import Crypto.Random (getRandomBytes)
import qualified Data.BIP39 as BIP39
import Crypto.KDF.PBKDF2 (generate, PRF(..), Parameters(..))
import Crypto.Hash.Algorithms (SHA512(..))
import qualified Data.Text as T

-- Generate a mnemonic phrase from entropy
generateMnemonic :: Int -> IO [T.Text]
generateMnemonic entropyBits = do
  let entropySize = entropyBits `div` 8
  entropy <- getRandomBytes entropySize
  case BIP39.mnemonicFromEntropy entropy of
    Right mnemonic -> return $ BIP39.mnemonicToWords mnemonic
    Left err -> error $ "Failed to generate mnemonic: " ++ show err

-- Generate a seed from the mnemonic and passphrase
generateSeed :: [T.Text] -> T.Text -> IO BS.ByteString
generateSeed mnemonicWords passphrase = do
  case BIP39.mnemonicFromWords mnemonicWords of
    Right mnemonic -> 
      return $ BIP39.mnemonicToSeed mnemonic (BIP39.Passphrase $ T.encodeUtf8 passphrase)
    Left err -> error $ "Invalid mnemonic: " ++ show err

-- Create a signing key from the seed (simplified)
createSigningKey :: BS.ByteString -> Api.SigningKey Api.PaymentKey
createSigningKey seed =
  let sk = Ed25519.unsafeSignKeyFromBytes $ BS.take 32 seed -- Simplified; handle errors in real code
  in Api.PaymentSigningKey (Api.ShelleySigningKey sk)

-- Derive the verification key from the signing key
getVerificationKey :: Api.SigningKey Api.PaymentKey -> Api.VerificationKey Api.PaymentKey
getVerificationKey (Api.PaymentSigningKey (Api.ShelleySigningKey sk)) =
  Api.PaymentVerificationKey (Api.ShelleyVerificationKey (Ed25519.deriveVerKey sk))

-- Generate a Shelley address from the verification key
createAddress :: Api.NetworkId -> Api.VerificationKey Api.PaymentKey -> Api.Address ShelleyAddr
createAddress networkId vKey =
  let paymentCred = Api.PaymentCredentialByKey (Api.verificationKeyHash vKey)
   in Api.makeShelleyAddress networkId paymentCred Api.NoStakeAddress

-- Example usage
main :: IO ()
main = do
  -- Generate a 12-word mnemonic (128 bits entropy)
  mnemonic <- generateMnemonic 128
  putStrLn "Mnemonic Phrase:"
  mapM_ print mnemonic

  -- Generate seed (use a secure passphrase in practice)
  seed <- generateSeed mnemonic ""
  putStrLn "\nSeed (hex):"
  print $ BS.unpack seed

  -- Create signing key
  let signingKey = createSigningKey seed
  putStrLn "\nSigning Key:"
  print signingKey

  -- Derive verification key
  let vKey = getVerificationKey signingKey
  putStrLn "\nVerification Key:"
  print vKey

  -- Create address on the Cardano Preprod testnet
  let networkId = Api.Testnet (Api.NetworkMagic 1)  -- Preprod testnet
  let address = createAddress networkId vKey
  putStrLn "\nAddress:"
  print address