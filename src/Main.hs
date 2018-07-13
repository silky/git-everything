{-# LANGUAGE OverloadedStrings #-}

module Main where

import Prelude hiding (FilePath)
import Control.Monad.IO.Class
import Options.Applicative
import Data.Monoid
import Data.String.Conv
import Data.Tagged
import Git hiding (Options)
import Git.Libgit2 (MonadLg, LgRepo, lgFactory)
import Git.Tree.Working
import Shelly


data Options = Options
  { repoDir :: String
  , destDir :: String
  }


options :: Parser Options
options = Options
  <$> strOption (short 'r' <> long "repo-dir" <> value "."
                  <> help "The directory of the repository to flatten. Default: \".\"")
  <*> strOption (short 'd' <> long "dest-dir"
                  <> help "The output directory")


main :: IO ()
main = execParser opts >>= go
  where
    opts = info (helper <*> options)
                (fullDesc <> progDesc desc <> header hdr)
    hdr  = "git-everything - flatten a git repository by commit."
    desc = "Flatten a git repository by checking out all the commits into a particular folder."


go :: Options -> IO ()
go opts = do
  withRepository lgFactory (repoDir opts) $ do
    Just ref <- resolveReference "HEAD"
    flip traverseCommits_ (Tagged ref) $ \tc -> do
      c <- lookupCommit tc

      let (Tagged cid) = tc
          newDir       = destDir opts ++ "/" ++ show cid     

      liftIO $ shelly $ do
        cmd "git" ["clone", repoDir opts, newDir]
        cd  (fromText (toS newDir))
        cmd "git" ["reset", "--hard", show cid]

