module Model
    exposing
        ( Model(..)
        , Message(..)
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
