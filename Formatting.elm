module Formatting exposing
    ( Align(..)
    , align
    , background
    , blueLine
    , bullet
    , bullets
    , code
    , crossedBullet
    , demo
    , image
    , linkBullet
    , padded
    , position
    , richtext
    , scale
    , shout
    , spacing
    , split
    , title
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown
import Model exposing (Message, Model)
import SliceShow.Content exposing (..)


type Align
    = Left
    | Right
    | Center


slidePadding : String
slidePadding =
    "70px 150px 10px"


{-| Custom slide that adds the padding
-}
padded : List (Content Model Message) -> Content Model Message
padded =
    div [ style "padding" slidePadding ]
        |> container


{-| Custom slide with the background
-}
background : String -> List (Content Model Message) -> Content Model Message
background url =
    div
        [ style "height" "100%"
        , style "box-sizing" "border-box"
        , style "background-image" ("url(" ++ url ++ ")")
        , style "background-size" "cover"
        , style "padding" slidePadding
        ]
        |> container


{-| Text alignment
-}
align : Align -> List (Content Model Message) -> Content Model Message
align align_ =
    let
        alignValue =
            case align_ of
                Left ->
                    "left"

                Right ->
                    "right"

                Center ->
                    "center"
    in
    div [ style "text-align" alignValue ]
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
    img [ src url, width wid, height hei, style "vertical-align" "middle" ] []
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
    div [ style "height" (String.fromInt px ++ "px") ] []
        |> item


{-| Absolute positioning
-}
position : ( Int, Int ) -> List (Content Model Message) -> Content Model Message
position ( x, y ) =
    div
        [ style "position" "absolute"
        , style "left" (String.fromInt x ++ "px")
        , style "top" (String.fromInt y ++ "px")
        ]
        |> container


{-| Demo
-}
demo : String -> Content Model Message
demo url =
    iframe
        [ src url
        , style "position" "absolute"
        , style "left" "0"
        , style "top" "0"
        , style "width" "100%"
        , style "height" "100%"
        , style "border" "0"
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
    item (li [ style "text-decoration" "line-through" ] [ text str ])


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
        [ style "position" "absolute"
        , style "left" "0"
        , style "right" "0"
        , style "top" "0"
        , style "bottom" "0"
        , style "padding" slidePadding
        , style "font" "90px/1.2 FiraSans-Light, sans-serif"
        , style "letter-spacing" "-2px"
        , style "text-align" "left"
        , style "display" "flex"
        , style "align-items" "center"
        ]
        [ div [] [ text str ] ]
        |> item


{-| Two columns view
-}
split : List (Content Model Message) -> List (Content Model Message) -> Content Model Message
split leftContent rightContent =
    container
        (table
            [ style "width" "100%"
            , style "table-layout" "fixed"
            , style "border-spacing" "0"
            , style "border-collapse" "collapse"
            , style "vertical-align" "top"
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
        [ style "transform" ("scale(" ++ String.fromFloat ratio ++ ")")
        , style "transform-origin" "0 0"
        ]
        |> container


{-| Blue line
-}
blueLine : Content Model Message
blueLine =
    div
        [ style "position" "absolute"
        , style "top" "0"
        , style "left" "0"
        , style "width" "100%"
        , style "border-top" "4px solid #60B5CC"
        , style "z-index" "2"
        ]
        []
        |> item
