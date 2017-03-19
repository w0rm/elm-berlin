module Slides exposing (slides)

import Model exposing (Model, Message)
import Formatting exposing (..)
import SliceShow.Slide exposing (..)
import SliceShow.Content exposing (Content, custom, container)


organizers : List (Content Model Message)
organizers =
    [ title "Organized by"
    , spacing 25
    , split
        [ image ( 250, 250 ) "assets/unsoundscapes.png"
        , richtext "Andrey Kuzmin  \n[@unsoundscapes](https://twitter.com/unsoundscapes)"
        ]
        [ image ( 250, 250 ) "assets/robinpokorny.jpg"
        , richtext "Robin Pokorny  \n[@robinpokorny](https://twitter.com/robinpokorny)"
        ]
    ]


bulletslide : String -> List String -> Content Model Message
bulletslide text list =
    padded
        [ title text
        , bullets <| List.map bullet list
        ]


slides : List (Slide Model Message)
slides =
    [ [ position ( 370, 470 )
            [ richtext "# [Elm Berlin #3](https://www.meetup.com/Elm-Berlin/events/238210075/)"
            ]
      , custom Model.tangram
      ]
    , [ padded organizers ]
    , [ padded [ title "Wi-Fi Info" ]
      ]
    , [ padded [ title "Code of Conduct" ] ]
    , [ bulletslide "Schedule"
            [ "19:00 — Open door"
            , "19:30 — Welcome Message"
            , "19:40 — Daniel Bachler: Using Elm for science"
            , "20:10 — Andrey Kuzmin: Introduction to WebGL in Elm"
            , "20:40 — Discussion"
            ]
      ]
    , [ padded [ title "Elm Europe" ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
