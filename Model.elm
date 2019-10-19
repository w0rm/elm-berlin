module Model exposing
    ( Message(..)
    , Model(..)
    , tangram
    )

import Tangram


type Message
    = TangramMessage Tangram.Message


type Model
    = TangramModel Tangram.Model


tangram : Model
tangram =
    TangramModel Tangram.initial
