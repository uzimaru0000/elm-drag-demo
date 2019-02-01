module Main exposing (main)

import Browser
import Browser.Events as Browser
import Element as UI
import Json.Decode as JD
import Model exposing (..)
import Point
import Update exposing (..)
import View exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view >> UI.layout []
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.ref /= Nothing then
        Point.decoder ( ["movementX"], ["movementY"] )
            |> JD.map Drag
            |> Browser.onMouseMove

    else
        Sub.none
