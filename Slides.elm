module Slides exposing (slides)

import Formatting exposing (..)
import Model exposing (Message, Model)
import SliceShow.Content exposing (Content, container, custom)
import SliceShow.Slide exposing (..)


organizers : List (Content Model Message)
organizers =
    [ title "Who we are"
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
                    "# [Elm Introductory Workshop](https://www.meetup.com/Elm-Berlin/)"
                ]
            ]
      ]
    , [ padded
            [ align Center
                [ title "Thanks to sponsors"
                , spacing 40
                , image ( 109 * 3, 24 * 3 ) "assets/noredink.svg"
                , spacing 30
                , image ( 98 * 4, 28 * 4 ) "assets/nextjournal.svg"
                , spacing 30
                , image ( 93 * 2, 54 * 2) "assets/soundcloud.svg"
                ]
            ]
      ]
    , [ padded organizers ]
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
                [ "9-10am: Check-in, breakfast and software installation"
                , "10am: Opening talk, student sorting"
                , "10:30am: Code"
                , "12:30pm: Lunch"
                , "1:30pm: Code"
                , "4:30pm: Closing talk, announcements & retrospectives"
                , "5-7pm: Afterparty (optional)"
                ]
            ]
      ]
    ]
        |> List.map ((::) blueLine)
        |> List.map slide
        |> List.map (SliceShow.Slide.setDimensions ( 1280, 720 ))
