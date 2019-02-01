module View exposing (view)

import Element as UI exposing (Element)
import Element.Background as BG
import Element.Border as Border
import Element.Events as UI
import Html.Attributes as Html
import Model exposing (..)
import Model.Entity exposing (..)
import Reference exposing (Reference)
import Reference.List as Reference
import Utils


view : Model -> Element Msg
view model =
    UI.row
        (Reference.top model.entities
            |> Reference.unwrap entityView
        )
        []


entityView : Reference Entity (List Entity) -> UI.Attribute Msg
entityView ref =
    let
        commonAttrs transform =
            transformAttr transform
                ++ [ Utils.stopPropagationOn "mouseup" End
                   , Utils.stopPropagationOn "mousedown" <| Select ref
                   , Html.style "cursor" "move" |> UI.htmlAttribute
                   ]
    in
    case Reference.this ref of
        Entity transform (Note entities) ->
            UI.el
                (commonAttrs transform
                    ++ (Reference.fromRecord
                            { this = entities
                            , rootWith = Reference.rootWith ref << Entity transform << Note
                            }
                            |> Reference.unwrap entityView
                       )
                    ++ [ BG.color <| UI.rgb 0.2 1.0 0.5 ]
                )
                UI.none
                |> UI.inFront

        Entity transform (Sticky str) ->
            UI.el
                (commonAttrs transform
                    ++ [ BG.color <| UI.rgb 0.2 0.5 1.0 ]
                )
                (UI.text str)
                |> UI.inFront
 

transformAttr : Transform -> List (UI.Attribute Msg)
transformAttr style =
    [ UI.moveDown <| toFloat style.pos.y
    , UI.moveRight <| toFloat style.pos.x
    , UI.width <| UI.px style.size.x
    , UI.height <| UI.px style.size.y
    ]
