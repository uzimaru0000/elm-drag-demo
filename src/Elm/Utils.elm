module Utils exposing (preventDefaultOn, stopPropagationOn)

import Element as UI
import Html exposing (Attribute)
import Html.Events as Html
import Json.Decode as JD


stopPropagationOn : String -> msg -> UI.Attribute msg
stopPropagationOn name msg =
    JD.succeed ( msg, True )
        |> Html.stopPropagationOn name
        |> UI.htmlAttribute


preventDefaultOn : String -> msg -> UI.Attribute msg
preventDefaultOn name msg =
    JD.succeed ( msg, True )
        |> Html.preventDefaultOn name
        |> UI.htmlAttribute
