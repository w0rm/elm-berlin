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
        [ image ( 250, 250 ) "assets/danielbachler.jpg"
        , richtext "Daniel Bachler  \n[@DanyX23](https://twitter.com/DanyX23)"
        ]
    ]


bulletslide : List String -> Content Model Message
bulletslide list =
    bullets <| List.map bullet list


slides : List (Slide Model Message)
slides =
    [ [ position ( 390, 470 )
            [ richtext
                "# [Hack Night](https://www.meetup.com/preview/Elm-Berlin/events/243644020)"
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
                , richtext "## [berlincodeofconduct.org](http://berlincodeofconduct.org)"
                ]
            ]
      ]
    , [ padded
            [ title "Schedule"
            , scale 1.1
                [ bulletslide
                    [ "19:00 — Open Door & Pizzas"
                    , "19:30 — Introduction Round"
                    , "20:00 — Hacking"
                    , "21:30 — Recap & Demos"
                    , "22:00 — The End"
                    ]
                ]
            ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
