module Main exposing (main)

import Html exposing (Html)
import Model exposing (Message(..), Model(..))
import SliceShow
import Slides exposing (slides)
import Tangram


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case ( message, model ) of
        ( TangramMessage a, TangramModel m ) ->
            let
                ( newModel, newEffect ) =
                    Tangram.update a m
            in
            ( TangramModel newModel, Cmd.map TangramMessage newEffect )


subscriptions : Model -> Sub Message
subscriptions model =
    case model of
        TangramModel m ->
            Tangram.subscriptions m |> Sub.map TangramMessage


view : Model -> Html Message
view model =
    case model of
        TangramModel fountain ->
            Tangram.view fountain |> Html.map TangramMessage


main : Program () (SliceShow.Model Model Message) (SliceShow.Message Message)
main =
    slides
        |> SliceShow.init
        |> SliceShow.setUpdate update
        |> SliceShow.setView view
        |> SliceShow.setSubscriptions subscriptions
        |> SliceShow.show
