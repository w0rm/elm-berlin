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
        [ spacing 20
        , image ( 372, 216 ) "assets/soundcloud.svg"
        ]
    ]


bulletslide : List String -> Content Model Message
bulletslide list =
    bullets <| List.map bullet list


slides : List (Slide Model Message)
slides =
    [ [ position ( 490, 490 )
            [ richtext
                "# [Hack Night](https://www.meetup.com/preview/Elm-Berlin/events/243644020)"
            ]
      , custom Model.tangram
      ]
    , [ padded organizers ]
    , [ padded
            [ align Center
                [ spacing 100
                , title "Wi-Fi: SoundCloud Guests"
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
                , richtext "## [berlincodeofconduct.org](http://berlincodeofconduct.org)"
                ]
            ]
      ]
    , [ padded
            [ title "Schedule"
            , bulletslide
                [ "19:00 — Open Door & Pizzas"
                , "19:30 — Introduction Round & Demos"
                , "20:00 — Hacking"
                , "21:30 — Recap & More Demos"
                , "22:00 — The End"
                ]
            ]
      ]
    , [ padded
            [ align Center
                [ title "Elm Game Jam"
                , richtext "March, April: “Randomness”"
                , spacing 20
                , image ( 2240 // 7, 1417 // 7 ) "assets/egc.png"
                , spacing 30
                , richtext "## [elmgames.club](http://elmgames.club/)"
                ]
            ]
      ]
    , [ padded
            [ align Center
                [ title "Elm Europe"
                , richtext "Paris, 5-6 July"
                , spacing 30
                , image ( 1200 // 5, 979 // 5 ) "assets/elm-europe.png"
                , spacing 30
                , richtext "## [elmeurope.org](https://elmeurope.org/)"
                ]
            ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
        |> List.map (SliceShow.Slide.setDimensions ( 1280, 720 ))
