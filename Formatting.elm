module Formatting
    exposing
        ( background
        , padded
        , title
        , align
        , image
        , Align(..)
        , richtext
        , spacing
        , position
        , demo
        , bullets
        , bullet
        , crossedBullet
        , linkBullet
        , code
        , shout
        , split
        , scale
        , blueLine
        )

import Model exposing (Model, Message)
import SliceShow.Content exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown


type Align
    = Left
    | Right
    | Center


slidePadding : String
slidePadding =
    "50px 100px"


{-| Custom slide that adds the padding
-}
padded : List (Content Model Message) -> Content Model Message
padded =
    div [ style [ ( "padding", slidePadding ) ] ]
        |> container


{-| Custom slide with the background
-}
background : String -> List (Content Model Message) -> Content Model Message
background url =
    div
        [ style
            [ ( "height", "100%" )
            , ( "box-sizing", "border-box" )
            , ( "background-image", "url(" ++ url ++ ")" )
            , ( "background-size", "cover" )
            , ( "padding", slidePadding )
            ]
        ]
        |> container


{-| Text alignment
-}
align : Align -> List (Content Model Message) -> Content Model Message
align align =
    let
        alignValue =
            case align of
                Left ->
                    "left"

                Right ->
                    "right"

                Center ->
                    "center"
    in
        div [ style [ ( "text-align", alignValue ) ] ]
            |> container


{-| Title content item
-}
title : String -> Content Model Message
title message =
    h1 [] [ text message ]
        |> item


{-| Image
-}
image : ( Int, Int ) -> String -> Content Model Message
image ( wid, hei ) url =
    img [ src url, width wid, height hei, style [ ( "vertical-align", "middle" ) ] ] []
        |> item


{-| Richtext
-}
richtext : String -> Content Model Message
richtext =
    Markdown.toHtml [] >> item


{-| Code block
-}
code : String -> String -> Content Model Message
code lang str =
    Markdown.toHtml [] ("```" ++ lang ++ "\n" ++ str ++ "\n```")
        |> item


{-| Vertical spacing
-}
spacing : Int -> Content Model Message
spacing px =
    div [ style [ ( "height", toString px ++ "px" ) ] ] []
        |> item


{-| Absolute positioning
-}
position : ( Int, Int ) -> List (Content Model Message) -> Content Model Message
position ( x, y ) =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "left", toString x ++ "px" )
            , ( "top", toString y ++ "px" )
            ]
        ]
        |> container


{-| Demo
-}
demo : String -> Content Model Message
demo url =
    iframe
        [ src url
        , style
            [ ( "position", "absolute" )
            , ( "left", "0" )
            , ( "top", "0" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            , ( "border", "0" )
            ]
        ]
        []
        |> item


{-| List
-}
bullets : List (Content Model Message) -> Content Model Message
bullets =
    container (ul [])


{-| List item
-}
bullet : String -> Content Model Message
bullet str =
    item (li [] [ text str ])


{-| List item
-}
crossedBullet : String -> Content Model Message
crossedBullet str =
    item (li [ style [ ( "text-decoration", "line-through" ) ] ] [ text str ])


{-| Link bullet
-}
linkBullet : String -> String -> Content Model Message
linkBullet url str =
    item (li [] [ a [ href url, target "_blank" ] [ text str ] ])


{-| Shout
-}
shout : String -> Content Model Message
shout str =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "left", "0" )
            , ( "right", "0" )
            , ( "top", "0" )
            , ( "bottom", "0" )
            , ( "padding", slidePadding )
            , ( "font", "90px/1.2 FiraSans-Light, sans-serif" )
            , ( "letter-spacing", "-2px" )
            , ( "text-align", "left" )
            , ( "display", "flex" )
            , ( "align-items", "center" )
            ]
        ]
        [ div [] [ text str ] ]
        |> item


{-| Two columns view
-}
split : List (Content Model Message) -> List (Content Model Message) -> Content Model Message
split leftContent rightContent =
    container
        (table
            [ style
                [ ( "width", "100%" )
                , ( "table-layout", "fixed" )
                , ( "border-spacing", "0" )
                , ( "border-collapse", "collapse" )
                ]
            ]
        )
        [ container (td []) leftContent
        , container (td []) rightContent
        ]


{-| Scale the content
-}
scale : Float -> List (Content Model Message) -> Content Model Message
scale ratio =
    div
        [ style
            [ ( "transform", "scale(" ++ toString ratio ++ ")" )
            , ( "transform-origin", "0 0" )
            ]
        ]
        |> container


{-| Blue line
-}
blueLine : Content Model Message
blueLine =
    div
        [ style
            [ ( "position", "absolute" )
            , ( "top", "0" )
            , ( "left", "0" )
            , ( "width", "100%" )
            , ( "border-top", "4px solid #60B5CC" )
            , ( "z-index", "2" )
            ]
        ]
        []
        |> item
