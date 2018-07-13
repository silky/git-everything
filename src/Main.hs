{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Control.Monad.IO.Class
import Data.Tagged
import Git
import Git.Tree.Working
import Git.Libgit2 (MonadLg, LgRepo, lgFactory)

main :: IO ()
main = do
  withRepository lgFactory ".." $ do
    liftIO $ putStrLn "Opened repo!"

    Just ref <- resolveReference "HEAD"
    flip traverseCommits_ (Tagged ref) $ \c -> do
      liftIO $ putStrLn "Found Commit!"
