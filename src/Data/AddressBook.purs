module Data.AddressBook where
  
import Prelude

import Control.Plus (empty)
import Data.List (List(..), filter, head)
import Data.Maybe (Maybe)

type Entry = {
    firstname :: String,
    lastname :: String,
    address :: Address
}

type Address = {
    street :: String,
    city :: String,
    state :: String
}

type AddressBook = List Entry  -- List is a type constructor :: takes a type <a> to return an object of type List <a>

emptyBook :: AddressBook
emptyBook = empty

showEntry :: Entry -> String -- Takes a parameter of type Entry and returns a String
showEntry entry = entry.firstname <> " " <> entry.lastname <> " " <> showAddress entry.address

showAddress :: Address -> String 
showAddress address = address.street <> ", " <> address.state <> ", " <> address.city

insertEntry :: Entry -> AddressBook -> AddressBook 
{- 
    Example of a curried function; all functions in Purs take one arg
    Evaluated as Entry -> (AddressBook -> AddressBook)
-}
insertEntry entry book = Cons entry book -- Cons defn : V a. a -> List a  this can be eta-reduced to just a Cons

findEntry :: String -> String -> AddressBook -> Maybe Entry
findEntry firstname lastname book = head $ filter filterEntry book
  where
    filterEntry :: Entry -> Boolean
    filterEntry entry = entry.firstname == firstname && entry.lastname == lastname

