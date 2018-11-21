module Slides exposing (slides)

import Formatting exposing (..)
import Model exposing (Message, Model)
import SliceShow.Content exposing (Content, container, custom)
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

    {-
       [ spacing 20
       , image ( 372, 216 ) "assets/soundcloud.svg"
       ]
    -}
    ]


bulletslide : List String -> Content Model Message
bulletslide list =
    bullets <| List.map bullet list


slides : List (Slide Model Message)
slides =
    [ [ background "assets/the-elm-architecture.jpg"
            [ position ( 30, 580 )
                [ richtext
                    "# [Code Night](https://www.meetup.com/Elm-Berlin/)"
                ]
            ]
      ]
    , [ padded organizers ]
    , [ padded
            [ align Center
                [ spacing 100
                , title "Wi-Fi: "
                , title "Password: "
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
                , "20:00 — Coding"
                , "21:30 — Recap & More Demos"
                , "22:00 — The End"
                ]
            ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
        |> List.map (SliceShow.Slide.setDimensions ( 1280, 720 ))
