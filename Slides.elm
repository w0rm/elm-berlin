module Slides exposing (slides)

import Formatting exposing (..)
import Model exposing (Message, Model)
import SliceShow.Content exposing (Content)
import SliceShow.Slide exposing (..)


organizers : List (Content Model Message)
organizers =
    [ title "Organized by"
    , spacing 25
    , split
        [ image ( 250, 250 ) "assets/unsoundscapes.png"
        , richtext "Andrey Kuzmin  \n[@unsoundscapes](https://twitter.com/unsoundscapes)"
        ]
        [ image ( 250, 250 ) "assets/michaelglass.png"
        , richtext "Michael Glass  \n[@michaelglass](https://twitter.com/michaelglass)"
        ]
    ]


bulletslide : List String -> Content Model Message
bulletslide list =
    bullets <| List.map bullet list


wifiSlide : List (Content Model Message)
wifiSlide =
    [ align Center
        [ spacing 100
        , title "Wi-Fi: "
        , title "Password: "
        ]
    ]


slides : List (Slide Model Message)
slides =
    [ background "assets/the-elm-architecture.jpg"
        [ position ( 30, 580 )
            [ richtext
                "# [Code Night](https://www.meetup.com/Elm-Berlin/)"
            ]
        ]
    , padded organizers
    , padded
        [ align Center
            [ title "Berlin Code of Conduct"
            , spacing 40
            , image ( 280, 210 ) "assets/berlincodeofconduct.png"
            , spacing 30
            , richtext "## [berlincodeofconduct.org](http://berlincodeofconduct.org)"
            ]
        ]
    , padded
        [ title "Schedule"
        , bulletslide
            [ "19:00 — Introduction Round"
            , "19:30 — Demos Round"
            , "20:30 — Open Chat"
            , "21:00 — The End"
            ]
        ]
    ]
        |> List.map (\content -> [ blueLine, content ])
        |> List.map slide
        |> List.map (SliceShow.Slide.setDimensions ( 1280, 720 ))
