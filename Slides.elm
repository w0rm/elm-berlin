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
        , richtext
            "Andrey Kuzmin  \n[@unsoundscapes](https://twitter.com/unsoundscapes)"
        ]
        [ image ( 250, 250 ) "assets/robinpokorny.jpg"
        , richtext
            "Robin Pokorny  \n[@robinpokorny](https://twitter.com/robinpokorny)"
        ]
    ]


bulletslide : List String -> Content Model Message
bulletslide list =
    bullets <| List.map bullet list


slides : List (Slide Model Message)
slides =
    [ [ position ( 370, 470 )
            [ richtext
                "# [Elm Berlin #3](https://www.meetup.com/Elm-Berlin/events/238210075/)"
            ]
      , custom Model.tangram
      ]
    , [ padded organizers ]
    , [ padded
            [ align Center
                [ spacing 100
                , title "Wi-Fi:"
                , title "Password:"
                , spacing 80
                , image ( 186, 108 ) "assets/soundcloud.svg"
                ]
            ]
      ]
    , [ padded
            [ align Center
                [ title "Berlin Code of Conduct"
                , spacing 40
                , image ( 280, 210 ) "assets/berlincodeofconduct.png"
                , spacing 30
                , richtext
                    "## [berlincodeofconduct.org](http://berlincodeofconduct.org)"
                ]
            ]
      ]
    , [ padded
            [ title "Schedule"
            , scale 1.3
                [ bulletslide
                    [ "19:00 — Open door"
                    , "19:30 — Welcome Message"
                    , "19:40 — Daniel Bachler: Using Elm for Science"
                    , "20:10 — Andrey Kuzmin: Introduction to WebGL in Elm"
                    , "20:40 — Lightning Talks & Discussion"
                    ]
                ]
            ]
      ]
    , [ padded
            [ title "Elm Europe 2017"
            , split
                [ bulletslide
                    [ "Takes place in Paris on June 8-9"
                    , "Keynotes by Evan Czaplicki and Richard Feldman"
                    , "Organized by the Elm community, for the Elm community"
                    ]
                ]
                [ align Right
                    [ image ( 360, 240 ) "assets/elmeurope.jpg" ]
                ]
            , spacing 50
            , align Center
                [ richtext "## [elmeurope.org](https://elmeurope.org)" ]
            ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
